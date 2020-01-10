module Fastlane
  module Actions
    class ProjE7UpdateAction < Action

      # 上傳 apk 至伺服器
      # platform - 平台 可帶入 android / ios
      # project - 專案 可帶入 app / backend
      # package_path - 包路徑
      def self.update_package(platform, project, package_path)

        filePutName = ""
        if platform == "android"
          filePutName = "apk"
        elsif platform == "ios"
          filePutName = "ipa"
        end

        projectPutName = ""
        if project == "app"
          projectPutName = "app"
        elsif project == "backend"
          projectPutName = "backend"
        end

        targetPath = ""
        if $isDebug
          targetPath = "/var/www/html/#{filePutName}/#{projectPutName}_debug.#{filePutName}"
        elsif $isRelease
          targetPath = "/var/www/html/#{filePutName}/#{projectPutName}_release.#{filePutName}"
        elsif $isProduct
          targetPath = "/var/www/html/#{filePutName}/#{projectPutName}_product.#{filePutName}"
        end

        # 上傳至伺服器
        UI.message "上傳#{filePutName}至伺服器中..."
        command = "scp -i fastlane/ssh/id_lottery51 #{package_path} water@18.162.107.44:#{targetPath}"
        Open3.popen3(command) do |stdin, stdout, stderr, thread|
          err = stderr.read.to_s
          isSuccess = err.empty?
          if isSuccess
            UI.important "#{filePutName}已上傳至伺服器"
          else
            UI.user_error!("上傳#{filePutName}錯誤: #{err}")
          end
        end
      end

      def self.description
        "上傳打包檔案"
      end

      def self.available_options
        # Action 需要傳入的參數, 以陣列分隔
        [
        ]
      end

      def self.authors
        ["https://github.com/MagicalWater/Water"]
      end

      def self.is_supported?(platform)
        platform == true
      end
    end
  end

end
