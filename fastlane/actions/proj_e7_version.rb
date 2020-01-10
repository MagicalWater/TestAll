module Fastlane
  module Actions
    class ProjE7VersionAction < Action

      # 取得伺服器最新版本
      def self.get_new_version(platform, project, debug, release, product)
        require 'net/http'
        require 'json'

        url = URI.parse('http://18.162.107.44/version.json')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }

        projectPutName = ""
        if project == "app"
          projectPutName = "e7App"
        elsif project == "backend"
          projectPutName = "e7Backend"
        end

        versionBody = res.body
        versionParseHash = JSON.parse(versionBody)
        platformHash = versionParseHash[projectPutName][platform]
        versionName = ""
        versionCode = 0

        typeHash = {}

        if debug
          typeHash = platformHash["debug"]
        elsif release
          typeHash = platformHash["release"]
        elsif product
          typeHash = platformHash["product"]
        end

        versionName = typeHash["versionName"]
        versionCode = typeHash["versionCode"]
        puts "當前版本 - #{versionName}+#{versionCode}"

        infoHash = {"name" => versionName, "code" => versionCode}
        infoHash
      end

      # 取得下一個版本號[用於自動新增版本號碼]
      def self.get_next_version(platform, project, debug, release, product)
        currentHash = get_new_version(platform, project, debug, release, product)
        versionName = currentHash["name"]
        versionCode = currentHash["code"]

        # code 自動 + 1
        versionCode = versionCode + 1

        # name 先分割, 數字超過 9 自動進位
        versionNameSplit = versionName.split(/\./)

        i = 0
        len = versionNameSplit.length
        while i < len
          index = len - i - 1
          numVal = versionNameSplit[index].to_i
          numVal = numVal + 1
          versionNameSplit[index] = "#{numVal}"
          if numVal >= 10 && index != 0
            # 添加往下加版號
            versionNameSplit[index] = "0"
            i = i+1
          else
            break
          end
        end


        versionName = versionNameSplit.join(".")

        infoHash = {"name" => versionName, "code" => versionCode}

        infoHash
      end

      # 修改版本訊息
      def self.modify_version(platform, project, debug, release, product)
        require 'net/http'
        require 'json'

        yamlHash = YamlParseAction.load()
        version = yamlHash["version"]
        versionMessage = nil
        if yamlHash.key?("version_message")
          versionMessage = yamlHash["version_message"]
        else
          UI.important "沒有找到版本訊息, 設置方式請在 pubspec.yaml 根節點加入 version_message"
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

        projectPutName = ""
        if project == "app"
          projectPutName = "e7App"
        elsif project == "backend"
          projectPutName = "e7Backend"
        end

        platformHash = versionParseHash[projectPutName][platform]

        typeHash = {}

        if debug
          typeHash = platformHash["debug"]
        elsif release
          typeHash = platformHash["release"]
        elsif product
          typeHash = platformHash["product"]
        end

        typeHash["versionName"] = versionName
        typeHash["versionCode"] = versionCode

        if versionMessage != nil
          typeHash["message"] = versionMessage
        end

        if debug
          platformHash["debug"] = typeHash
        elsif release
          platformHash["release"] = typeHash
        elsif product
          platformHash["product"] = typeHash
        end

        versionParseHash[projectPutName][platform] = platformHash
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

      def self.description
        "e7 版本訊息"
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
        true
      end
    end
  end

end
