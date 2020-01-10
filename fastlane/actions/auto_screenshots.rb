module Fastlane
  module Actions
    class AutoScreenshotsAction < Action
      def self.run(params)

        # 修改 main.dart
        # 將環境更改為正式環境, 以及appcode更改為 APPTEST
        # 以及忽略權限開啟功能
        self.tmp_main_file

        # 先刪除模擬器服務
        system "adb -s emulator-5554 emu kill"
        system "killall -9 com.apple.CoreSimulator.CoreSimulatorService"

        sleep(5)

        # android 自動截圖
        if (params[:android_enabled])
          self.android_screenshots(params[:android_output_path])
        end

        # ios 自動截圖
        if (params[:ios_enabled])
          self.ios_screenshots(params[:ios_output_path])
        end

        # 恢復 main.dart
        self.restore_main_file

      end

      def self.android_screenshots(output_path)

        outputPath = output_path + "/screenshots"

        targetPath = "./android/app/build.gradle"

        # 變更 gradle 截圖屬性
        gradleString = File.read(targetPath, :encoding => 'UTF-8')

        oriFlavorEnabled = "true"

        replaceString = gradleString.gsub(/(?<=flavorEnabled = )\w+/) {|enabled|
          oriFlavorEnabled = enabled
          'false'
        }

        File.write(targetPath, replaceString)

        # 將 test_deiver 下的 screenshots 替換為 android 版本的
        FileUtils.cp "test_driver/screenshots_android.yaml", "test_driver/screenshots.yaml"

        # 開始截圖
        system "screenshots --config=test_driver/screenshots.yaml"

        # 截圖完之後回覆 gradle 的 flavorEnabled
        File.write(targetPath, gradleString)

        # 將截圖移至附檔
        FileUtils.mkdir_p(outputPath)

        self.nexus5x().each { |path|
          #puts "打印名稱 (nexus5x) #{path}"
          FileUtils.cp path, outputPath
          name = File.basename(path)
          system "convert '#{path}' -resize 1080x2248! -quality 100 '附檔/android/screenshots/#{name}'"
        }

        FileUtils.rm_rf('./android/fastlane')

      end

      def self.ios_screenshots(output_path)
        # 將 test_deiver 下的 screenshots 替換為 ios 版本的
        FileUtils.cp "test_driver/screenshots_ios.yaml" "test_driver/screenshots.yaml"

        # 開始截圖
        system "screenshots --config=test_driver/screenshots.yaml"

        outputPath = output_path + "/screenshots"

        # 截圖完成之後將檔案移至附檔

        iPad3rdPath = "#{outputPath}/iPad3rd"
        iPad2ndPath = "#{outputPath}/iPad2nd"
        iPhoneXsPath = "#{outputPath}/iPhoneXs"
        iPhone8Path = "#{outputPath}/iPhone8"

        FileUtils.mkdir_p(iPad3rdPath)
        FileUtils.mkdir_p(iPad2ndPath)
        FileUtils.mkdir_p(iPhoneXsPath)
        FileUtils.mkdir_p(iPhone8Path)

        self.iPad3rd().each { |path|
          #puts "打印名稱 (3rd) #{path}"
          FileUtils.cp path, iPad3rdPath
        }

        self.iPad2nd().each { |path|
          #puts "打印名稱 (2nd) #{path}"
          FileUtils.cp path, iPad2ndPath
        }

        self.iPhoneXs().each { |path|
          #puts "打印名稱 (iphoneXs) #{path}"
          FileUtils.cp path, iPhoneXsPath
        }

        self.iPhone8().each { |path|
          #puts "打印名稱 (iphone8) #{path}"
          FileUtils.cp path, iPhone8Path
        }

        FileUtils.rm_rf('./ios/fastlane')
      end

      # 將main暫時改為需要截圖的環境
      def self.tmp_main_file()

        # 先備份 main
        FileUtils.cp "./lib/main.dart", "./lib/main_tmp.dart"

        text = File.read("./lib/main.dart", :encoding => 'UTF-8')

        newAppCode = "APPTEST"
        newHost = "Host.release1"
        newPermissionIgnore = "true"

        text = text.gsub(/(?<=appCode: ")(\w)+(?=")/) {|appCode|
          newAppCode
        }

        text = text.gsub(/(?<=host: )(\w|\.)+(?=\,)/) {|host|
          newHost
        }

        text = text.gsub(/(?<=ignorePermissionFuture: )(\w|\.)+(?=\,)/) {|ignore|
          newPermissionIgnore
        }

        File.write("./lib/main.dart", text)
      end

      # 回覆 main
      def self.restore_main_file()
        FileUtils.cp "./lib/main_tmp.dart", "./lib/main.dart"
      end

      def self.nexus5x()
        search = "Nexus 5X"
        self.android_file_get(search)
      end

      def self.iPad3rd()
        search = "iPad Pro (12.9-inch) (3rd generation)"
        self.ios_file_get(search)
      end

      def self.iPad2nd()
        search = "iPad Pro (12.9-inch) (2nd generation)"
        self.ios_file_get(search)
      end

      def self.iPhoneXs()
        search = "iPhone Xs"
        self.ios_file_get(search)
      end

      def self.iPhone8()
        search = "iPhone 7"
        self.ios_file_get(search)
      end

      def self.android_file_get(search)
        self.file_get("android/fastlane/metadata/android/zh-CN/images/phoneScreenshots", search)
      end

      def self.ios_file_get(search)
        self.file_get("ios/fastlane/screenshots/zh-CN", search)
      end

      def self.file_get(path, search)
        files = []
        FileUtils.mkdir_p(path)
        Dir.foreach(path) do |entry|
          isContain = entry.include? search
          if entry != "." && entry != ".." && isContain
            filePath = File.join("#{Dir.pwd}/#{path}", entry).to_s
            files << filePath
          end
        end
        files
      end

      def self.description
        "基於集成測試的自動化截圖"
      end

      def self.available_options
        # Action 需要傳入的參數, 以陣列分隔
        [
          FastlaneCore::ConfigItem.new(
            key: :ios_output_path,
            description: "ios截圖輸出路徑",
            optional: false, # 是否可以省略
            is_string: true, # 是不是字串
          ),
          FastlaneCore::ConfigItem.new(
            key: :android_output_path,
            description: "android截圖輸出路徑",
            optional: false, # 是否可以省略
            is_string: true, # 是不是字串
          ),
          FastlaneCore::ConfigItem.new(
            key: :android_enabled,
            description: "android是否截圖",
            optional: false, # 是否可以省略
            is_string: false, # 是不是字串
          ),
          FastlaneCore::ConfigItem.new(
            key: :ios_enabled,
            description: "ios是否截圖",
            optional: false, # 是否可以省略
            is_string: false, # 是不是字串
          ),
        ]
      end

      def self.authors
        ["https://github.com/MagicalWater/Water"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
