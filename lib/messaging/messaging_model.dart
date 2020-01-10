//import 'dart:convert';
//import 'messaging.dart';
//
///// 基本訊息物件
//abstract class Messaging {
//  dynamic _extrasInfo;
//
//  String get debugMessage;
//
//  dynamic get extrasInfo => _extrasInfo;
//
//  String get showing;
//
//  void setExtrasInfo(dynamic data) => _extrasInfo = data;
//
//  @override
//  String toString() {
//    var map = {};
//    map["showing"] = showing;
//    if (debugMessage != null) map["debug"] = debugMessage;
//    if (extrasInfo != null) map["extras"] = extrasInfo;
//
//    return jsonEncode(map);
//  }
//}
//
///// 直接包含內容的訊息物件
//class StringMessaging extends Messaging {
//  final String debugMessage;
//  final String showing;
//
//  StringMessaging(this.showing, [this.debugMessage]);
//}
//
///// 錯誤處理的訊息物件
//class ErrorMessaging extends Messaging {
//  final String errorMessage;
//  final StackTrace stackTrace;
//
//  ErrorMessaging.of(String errorMessage, [this.stackTrace]) : errorMessage = errorMessage;
//
//  @override
//  String get showing => errorMessage;
//
//  @override
//  String get debugMessage => "error: $errorMessage\nstack:\n$stackTrace";
//}
//
///// 可路由的訊息物件
//class RoutingMessaging extends Messaging {
//  final List<String> routing;
//  String _debugMessage;
//
//  RoutingMessaging.create(List<dynamic> routing) : routing = routing.map((o) => o?.toString()).toList();
//
//  RoutingMessaging.of(
//    dynamic routing1, [
//    dynamic routing2,
//    dynamic routing3,
//    dynamic routing4,
//    dynamic routing5,
//    dynamic routing6,
//    dynamic routing7,
//    dynamic routing8,
//    dynamic routing9,
//  ]) : this.create(
//          [
//            routing1,
//            routing2,
//            routing3,
//            routing4,
//            routing5,
//            routing6,
//            routing7,
//            routing8,
//            routing9,
//          ].where((o) => o != null).toList(),
//        );
//
//  @override
//  String get showing {
//    var mapper = MessagingMapper.getInstance();
//    if (mapper.isLoaded) {
//      var m = mapper.currentRouteData[routing.join(".")]?.message;
//      print("[INFO] messaing routing: $routing='$m'");
//      return m;
//    } else {
//      print("[WARING]: ErrorMapper is not loaded.");
//    }
//    return null;
//  }
//
//  @override
//  String get debugMessage => _debugMessage;
//
//  void setDebugMessage(String message) => _debugMessage = message;
//}
