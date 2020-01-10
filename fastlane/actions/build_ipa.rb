module Fastlane
  module Actions
    class BuildIpaAction < Action

      def self.run(params)
        config = params[:env_hash]
        system "flutter clean"
        system "flutter build ios --release"
        ipaPath = "./build/ios/iphoneos"
        dist = "#{config['ios_output']}"
        FileUtils.copy_entry ipaPath, dist
      end

      def self.description
        "生成空包 ipa"
      end

      def self.available_options
        # Action 需要傳入的參數, 以陣列分隔
        [
          FastlaneCore::ConfigItem.new(
            key: :env_hash,
            description: "所有環境變數, 包含渠道",
            optional: false, # 是否可以省略
            is_string: false, # 是不是字串
          )
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
