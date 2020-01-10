module Fastlane
  module Actions
    class SetAppInfoEnvAction < Action
      def self.run(params)
        androidName = params[:android_name]
        iosName = params[:ios_name]
        releaseHost = params[:release]

        self.place_env()
        self.change_name(androidName, iosName)

        if !releaseHost.nil?
          self.change_host(nil, releaseHost)
        end
      end

      # 變更 app 渠道到 release, 如果是 debug 的話
      def self.change_host(env_path, is_release)
        filePath = ""
        if env_path.nil?
          filePath = 'lib/main_env.dart'
        else
          filePath = env_path
        end

        text = File.read(filePath, :encoding => 'UTF-8')

        text = text.gsub(/(?<=Host appHost = ).+(?=;)/) { |name|
          text = name
          if name.include?("Host.debug") && is_release
            UI.message "debug 環境, 更改至 release1"
            text = "Host.release1"
          elsif name.include?("Host.release") && !is_release
            UI.message "release 環境, 更改至 debug"
            text = "Host.debug1"
          end
          text
        }

        File.write(filePath, text)
      end

      # 更改 app name
      def self.change_name(android, ios)
        puts "更改名稱: android #{android}, ios #{ios}"
        text = File.read('lib/main_env.dart', :encoding => 'UTF-8')
        if !android.to_s.empty?
          text = text.gsub(/(?<=androidName = ").+(?=")/) { |name|
            android
          }
        end
        if !ios.to_s.empty?
          text = text.gsub(/(?<=iosName = ").+(?=")/) { |name|
            ios
          }
        end
        text = File.write('lib/main_env.dart', text)
      end

      # 放置 env file
      def self.place_env()
        if !File.exist?("lib/main_env.dart")
          text = %{import 'dart:io' show Platform;
import 'package:mx_base/mx_base.dart';

const String androidName = "預設值";
const String iosName = "預設值";
const Host appHost = Host.release1;

String get appName => Platform.isAndroid ? androidName : iosName;}
          File.write("lib/main_env.dart", text)
        end
      end

      def self.description
        "將 config 的 app name 設置至 main_env.dart"
      end

      def self.authors
        ["https://github.com/MagicalWater/Water"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :android_name,
            description: "Android App 名稱",
            is_string: true,
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :ios_name,
            description: "iOS App 名稱",
            is_string: true,
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :release,
            description: "是否為 release host",
            is_string: false,
            optional: true
          ),
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
