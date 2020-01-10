module Fastlane
  module Actions
    class PackageE7backendAndroidAction < Action

      def self.run(params)
        config = params[:env_hash]
        needClean = params[:need_clean]
        isDebug = params[:debug].downcase != "n"

        check_is_e7_backend_project()

        if isDebug
          UI.important "Android E7-超級代理, 打包模式: debug"
        else
          UI.important "Android E7-超級代理, 打包模式: release, 為求安全性, 暫時不開放 release"
          return
        end

        # 輸出目的
        dest = "#{config['android_output']}"
        FileUtils.mkdir_p(dest)

        # 編譯源碼
        build_source(isDebug, dest, needClean)

        # 上傳 apk
        update_apk(isDebug, dest)

        # 修改版本號碼
        modify_version_file(isDebug)

      end

      # 檢查當前專案是否為 e7 backend app
      def self.check_is_e7_backend_project()
        yamlHash = YamlParseAction.load()
        projectName = yamlHash["name"]
        if projectName != "e7_backend"
          UI.user_error!("當前專案並非是 e7 backend, 無法打包上傳: #{projectName}")
        end
      end

      # 上傳 apk 至伺服器
      def self.update_apk(is_debug, output_path)

        apkPath = ""
        targetPath = ""
        if is_debug
          apkPath = "#{output_path}/debug.apk"
          targetPath = "/var/www/html/apk/backend_debug.apk"
        else
          apkPath = "#{output_path}/release.apk"
          targetPath = "/var/www/html/apk/backend_release.apk"
        end

        # 上傳至伺服器
        UI.message "上傳apk至伺服器中..."
        command = "scp -i fastlane/ssh/id_lottery51 #{apkPath} water@18.162.107.44:#{targetPath}"
        Open3.popen3(command) do |stdin, stdout, stderr, thread|
          err = stderr.read.to_s
          isSuccess = err.empty?
          if isSuccess
            UI.important "apk已上傳至伺服器"
          else
            UI.user_error!("上傳apk錯誤: #{err}")
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
        androidHash = versionParseHash["e7Backend"]["android"]
        if is_debug
          androidHash["debug"]["versionName"] = versionName
          androidHash["debug"]["versionCode"] = versionCode
          if versionMessage != nil
            androidHash["debug"]["message"] = versionMessage
          end
        else
          androidHash["release"]["versionName"] = versionName
          androidHash["release"]["versionCode"] = versionCode
          if versionMessage != nil
            androidHash["release"]["message"] = versionMessage
          end
        end
        versionParseHash["e7Backend"]["android"] = androidHash
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
      def self.build_source(is_debug, output_path, need_clean)
        if need_clean == false
        elsif !is_debug || need_clean == true
          system "flutter clean"
          system "flutter pub get"
        end
        command = ""

        if is_debug
          command = "flutter build apk --debug --flavor=tonone"
        else
          command = "flutter build apk --release --flavor=tonone"
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
            UI.error "編譯有錯誤或警告"
            errorSplit = err.split("\n")
            ignoreWarning = true
            errorSplit.each { |errorInfo|
              errorInfo = errorInfo.downcase
              if (errorInfo.start_with?("note:")) || (errorInfo.start_with?("warning:")) || (errorInfo.start_with?("! "))
                # 忽略 Note 以及警告
              else
                ignoreWarning = false
              end
            }

            if ignoreWarning
              UI.important "檢測為 Note 或 Warning 的錯誤, 進行忽略: \n#{err}"
            else
              # 錯誤不可忽略
              UI.user_error!("無法忽略的錯誤: \n#{err}")
            end

          end
        end

        sourcePath = ""
        destPath = ""

        # 將 apk 移至export
        if is_debug
          sourcePath = "./build/app/outputs/apk/toNone/debug/app-toNone-debug.apk"
          destPath = "#{output_path}/debug.apk"
        else
          sourcePath = "./build/app/outputs/apk/toNone/debug/app-toNone-release.apk"
          destPath = "#{output_path}/release.apk"
        end

        FileUtils.cp(sourcePath, destPath)

      end

      def self.description
        "Android 打包 e7 超級代理 app"
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
        platform == :android
      end
    end
  end

end
