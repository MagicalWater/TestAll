import 'dart:io' show Platform;

const String androidName = "抖影电影";
const String iosName = "抖影电影";

String get appName => Platform.isAndroid ? androidName : iosName;