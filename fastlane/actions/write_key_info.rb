module Fastlane
  module Actions

    class WriteKeyInfoAction < Action
      def self.run(params)
        name = params[:name]
        resRepPath = ENV['APPCMS_RESOURCES']
        jksPath = "#{name}/#{resRepPath}/key.jks"

        keyAlias = params[:keyAlias]
        password = params[:password]

        content = 
        %(storeFile=#{resRepPath}/Android/#{name}/key.jks
storePassword=#{password}
keyAlias=#{keyAlias}
keyPassword=#{password})

        puts "Current path: #{Dir.pwd}"
        FileUtils.touch('./android/key.properties')
        File.write('./android/key.properties', content)
      end

      def self.description
        "設置 android 簽名 key file 相關訊息"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :name,
            description: "簡體中文名稱",
            optional: false,
            is_string: true,),
          FastlaneCore::ConfigItem.new(key: :password,
            description: "密碼, file 跟 key 同個",
            optional: false,
            is_string: true,),
          FastlaneCore::ConfigItem.new(key: :keyAlias,
            description: "Key Alias",
            optional: false,
            is_string: true,),
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
