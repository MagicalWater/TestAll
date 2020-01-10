module Fastlane
  module Actions
    class ProjE7PackageIosAction < Action

      $isDebug = false
      $isRelease = false
      $isProduct = false

      $isVersionIncrease = false
      $isVersionKeep = false
      $isVersionCustom = false

      def self.run(params)
        config = params[:env_hash]
        needClean = params[:need_clean]
        packageType = params[:type]
        increaseVersion = params[:increase_version]
        specialVersion = params[:special_version]

        ProjE7PackageAndroidAction.check_is_e7_app_project()

        UI.important "專案 - E7 APP"

        if packageType == "3"
          $isProduct = true
        elsif packageType == "2"
          $isRelease = true
        else
          $isDebug = true
        end

        if increaseVersion == "3"
          UI.important "自訂版本號"
          $isVersionCustom = true
          if specialVersion == nil
            if versionType == "3" && versionSpecial == nil
              UI.important "指定版本(格式 name+code - 例 0.1.1+2): "
              versionSpecial = $stdin.gets.chomp
            end
          end
          puts "指定版本 - #{specialVersion}"
        elsif increaseVersion == "2"
          UI.important "保持版本號不變"
          $isVersionKeep = true
          versionHash = ProjE7VersionAction.get_new_version("ios", "app", $isDebug, $isRelease, $isProduct)
          specialVersion = "#{versionHash["name"]}+#{versionHash["code"]}"
          puts "版本保持不變 - #{specialVersion}"
        else
          UI.important "自動增加版本號"
          $isVersionIncrease = true
          versionHash = ProjE7VersionAction.get_next_version("ios", "app", $isDebug, $isRelease, $isProduct)
          specialVersion = "#{versionHash["name"]}+#{versionHash["code"]}"
          puts "自動遞增版本 - #{specialVersion}"
        end

        # 編譯打包, 取得打包後的 path
        ipaPath = PackageIosAction.run(
          env_hash: config,
          need_clean: needClean,
          type: packageType,
          version: specialVersion
        )

        # 將 ipa 上傳至伺服器
        ProjE7UpdateAction.update_package("ios", "app", ipaPath)

        # 修改版本號碼
        ProjE7VersionAction.modify_version("ios", "app", $isDebug, $isRelease, $isProduct)

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
            key: :type,
            description: "打包模式(輸入index)\n1. debug (默認)\n2. release\n3. product",
            optional: false,
            is_string: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :special_version,
            description: "指定版本",
            optional: true,
            is_string: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :increase_version,
            description: "版號(輸入index)\n1. 自動增加 (默認)\n2. 不變\n3. 自訂",
            optional: false,
            is_string: true,
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
