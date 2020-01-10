module Fastlane
  module Actions
    class PackageE7appIosAction < Action

      def self.run(params)
        config = params[:env_hash]
        needClean = params[:need_clean]
        isDebug = params[:debug].downcase != "n"

        check_is_e7_app_project()

        if isDebug
          UI.important "IOS E7-app, 打包模式: debug"
        else
          UI.important "IOS E7-app, 打包模式: release, 為求安全性, 暫時不開放 release"
          return
        end

        # 輸出目的
        dest = "#{config['ios_output']}"
        FileUtils.mkdir_p(dest)

        # app icon 名稱
        appIcon = "./assets/images/#{config['ios_app_icon']}"

        # 檢查圖片是否存在
        if !(File.exist?(appIcon))
          UI.user_error!("圖片: #{appIcon} 不存在, 請檢查錯誤")
        end

        # 編譯源碼
        build_source(isDebug, needClean)

        # 打包空包
        package_empty(isDebug, dest, appIcon)

        # 將 ipa 上傳至伺服器
        update_ipa(isDebug, dest)

        # 修改版本號碼
        modify_version_file(isDebug)

      end

      # 檢查當前專案是否為 e7app
      def self.check_is_e7_app_project()
        yamlHash = YamlParseAction.load()
        projectName = yamlHash["name"]
        if projectName != "platform_e7"
          UI.user_error!("當前專案並非是 e7 app, 無法打包上傳: #{projectName}")
        end
      end

      # 上傳 ipa 至伺服器
      def self.update_ipa(is_debug, output_path)

        ipaPath = ""
        targetPath = ""
        if is_debug
          ipaPath = "#{output_path}/debug.ipa"
          targetPath = "/var/www/html/ipa/app_debug.ipa"
        else
          ipaPath = "#{output_path}/release.ipa"
          targetPath = "/var/www/html/ipa/app_release.ipa"
        end

        # 上傳至伺服器
        UI.message "上傳 ipa 至伺服器中..."
        command = "scp -i fastlane/ssh/id_lottery51 #{ipaPath} water@18.162.107.44:#{targetPath}"
        Open3.popen3(command) do |stdin, stdout, stderr, thread|
          err = stderr.read.to_s
          isSuccess = err.empty?
          if isSuccess
            UI.important "ipa已上傳至伺服器"
          else
            UI.user_error!("上傳ipa錯誤: #{err}")
            UI.message "繼續往下執行"
          end
        end
      end

      # 修改版本訊息
      def self.modify_version_file(is_debug)
        require 'net/http'
        require 'json'

        yamlHash = YamlParseAction.load()
        version = yamlHash["version"]
        versionMessage = nil
        if yamlHash.key?("version_message")
          versionMessage = yamlHash["version_message"]
        else
          UI.important "沒有找到版本訊息, 設置方式請在 pubspec.yaml 根節點加入 versionMessage"
        end
        versionName = version.match(/.+(?=\+)/)[0]
        versionCode = version.match(/(?<=\+).+/)[0].to_i

        url = URI.parse('http://18.162.107.44/version.json')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        versionBody = res.body
        versionParseHash = JSON.parse(versionBody)
        iosHash = versionParseHash["e7App"]["ios"]
        if is_debug
          iosHash["debug"]["versionName"] = versionName
          iosHash["debug"]["versionCode"] = versionCode
          if versionMessage != nil
            iosHash["debug"]["message"] = versionMessage
          end
        else
          iosHash["release"]["versionName"] = versionName
          iosHash["release"]["versionCode"] = versionCode
          if versionMessage != nil
            iosHash["release"]["message"] = versionMessage
          end
        end
        versionParseHash["e7App"]["ios"] = iosHash
        versionBody = JSON.pretty_generate(versionParseHash)

        # 寫入修改的 version 到本地
        tempVersionPath = "./temp_version.json"
        File.write(tempVersionPath, versionBody)

        # 上傳至伺服器
        UI.message "上傳版本文件至伺服器中..."
        command = "scp -i fastlane/ssh/id_lottery51 #{tempVersionPath} water@18.162.107.44:/var/www/html/version.json"
        Open3.popen3(command) do |stdin, stdout, stderr, thread|
          err = stderr.read.to_s
          isSuccess = err.empty?
          if isSuccess
            UI.important "版本文件已上傳至伺服器"
          else
            UI.user_error!("上傳版本文件錯誤: #{err}")
            UI.message "繼續往下執行"
          end
        end
      end

      # 執行編譯
      def self.build_source(is_debug, need_clean)
        if need_clean == false
        elsif !is_debug || need_clean == true
          system "flutter clean"
          system "flutter pub get"
        end
        command = ""

        if is_debug
          command = "flutter build ios --debug"
        else
          command = "flutter build ios --release"
        end

        UI.message "執行編譯指令: #{command}"
        UI.message "編譯中..."

        # 執行 clean 以及 build
        Open3.popen3(command) do |stdin, stdout, stderr, thread|
          err = stderr.read.to_s
          isSuccess = err.empty?
          if isSuccess
            UI.message "編譯完畢, 開始打包"
          else
            UI.user_error!("編譯發生錯誤: #{err}")
            #UI.error "編譯有錯誤或警告, 等待 5 秒後繼續往下執行: #{err}"
            #sleep 5
          end
        end

      end

      # 打包成空包
      def self.package_empty(is_debug, dest, app_icon_path)
        # 創建一個 temp 資料夾
        tempPath = "#{dest}/temp"
        tempPayloadPath = "#{tempPath}/Payload"

        FileUtils.mkdir_p(tempPayloadPath)

        # 放置 app_icon
        # app icon 目標位置
        iconDestPath = "#{tempPath}/iTunesArtwork"

        place_app_icon(app_icon_path, iconDestPath, 1024, 1024)

        ipaPath = "./build/ios/iphoneos"
        FileUtils.copy_entry ipaPath, tempPayloadPath

        # 將 資料夾跟圖片放去 zip
        isWindows = PlatformAction.is_windows
        if isWindows
          system "cd #{tempPath} & zip Payload.zip iTunesArtwork -r Payload"
        else
          system "cd #{tempPath}; zip Payload.zip iTunesArtwork -r Payload"
        end

        if is_debug
          FileUtils.mv("#{tempPath}/Payload.zip", "#{dest}/debug.ipa")
        else
          FileUtils.mv("#{tempPath}/Payload.zip", "#{dest}/release.ipa")
        end
        FileUtils.rm_rf(tempPath)
      end

      # 變更圖片大小, 並放置到指定位置
      def self.place_app_icon(source, dest, width, height)
        require 'rmagick'
        image = Magick::Image.read(source).first

        image.change_geometry!("#{width}x#{height}") { |cols, rows, img|
            newimg = img.resize(width, height)
            newimg.write(dest)

            img = Magick::ImageList.new(dest)
            img.background_color = "white"
            img.flatten_images.write(dest)
        }
      end

      def self.description
        "Ios 打包 e7 app"
      end

      def self.available_options
        # Action 需要傳入的參數, 以陣列分隔
        [
          FastlaneCore::ConfigItem.new(
            key: :env_hash,
            description: "所有環境變數, 包含渠道",
            optional: false, # 是否可以省略
            is_string: false, # 是不是字串
          ),
          FastlaneCore::ConfigItem.new(
            key: :debug,
            description: "打包模式是否為debug (y/n) ",
            optional: false,
            is_string: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :need_clean,
            description: "打包前是否執行 clean",
            optional: true,
            is_string: false,
          ),
        ]
      end

      def self.authors
        ["https://github.com/MagicalWater/Water"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end

end
