module Fastlane
  module Actions
    class PullCertAndroidAction < Action
      def self.run(params)

        resPath = params[:appcms_res_path]

        if !resPath.nil? && resPath.length > 1 && File.exist?(resPath)
          system "java -jar fastlane/jars/resources-auto-sync.jar -r #{resPath}"
        else
          UI.important "找不到本地 AppCMS-Resource 倉庫的路徑, 請先確定路徑正確: #{resPath}"
        end
      end

      def self.description
        "將google雲端硬碟裡的證書同步到app cms裡"
      end

      def self.authors
        ["https://github.com/MagicalWater/Water"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :appcms_res_path,
            description: "本地 AppCMS-Resource 倉庫的路徑",
            is_string: true,
            optional: false
          ),
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
