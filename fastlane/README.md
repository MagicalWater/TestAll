fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### list_version
```
fastlane list_version
```
列出所有腳本版本
### check_version
```
fastlane check_version
```
檢查腳本版本
### update_script
```
fastlane update_script
```
更新 腳本, 並且安裝必要套件, 可接受參數 verion - 指定版本, clear - 本地檔案完整清除
### construct_project
```
fastlane construct_project
```
初始構建專案
### auto_generate
```
fastlane auto_generate
```
自動生成 Route(三大組件) / assets / json, 最後會自動執行 build_runner
### build_runner
```
fastlane build_runner
```
封裝好快速執行 build_runner build的指令
### build_runner_clean
```
fastlane build_runner_clean
```
封裝好快速執行 build_runner clean的指令
### package_e7_app_for_all
```
fastlane package_e7_app_for_all
```
一次打包 android 與 ios 的 e7 app 並上傳到伺服器
### package_e7_backend_for_all
```
fastlane package_e7_backend_for_all
```
一次打包 android 與 ios 的 e7 超級代理 並上傳到伺服器

----

## iOS
### ios update_app
```
fastlane ios update_app
```
更新 ios 包名/app名稱
### ios package_e7_app
```
fastlane ios package_e7_app
```
打包 ios e7 app 並上傳到伺服器
### ios package_e7_backend
```
fastlane ios package_e7_backend
```
打包 ios e7 超級代理 並上傳到伺服器
### ios mx_setting
```
fastlane ios mx_setting
```
流產線 -> 創建app -> 相關所有證書 -> 開啟自動簽名

----

## Android
### android update_app
```
fastlane android update_app
```
更新 android 包名/app名稱
### android package_e7_app
```
fastlane android package_e7_app
```
打包 android e7 app 並上傳到伺服器
### android package_e7_backend
```
fastlane android package_e7_backend
```
打包 android e7 超級代理 並上傳到伺服器
### android update_key
```
fastlane android update_key
```
設置 key 資訊

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
