//import 'dart:convert';
//
//import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';
//import 'package:xson/xson.dart';
//import 'package:yaml/yaml.dart' as yaml;
//
//class MessagingMapper {
//  static const String _KEY_MESSAGE = "message";
//  static const String _KEY_ROUTES = "routes";
//  static const String _KEY_REMARK = "remark";
//
//  static final MessagingMapper _instance = MessagingMapper._();
//
//  MessagingMapper._();
//
//  static MessagingMapper getInstance() => _instance;
//
//  MessagingRouteData _currentRouteData;
//
//  MessagingRouteData get currentRouteData => _currentRouteData;
//
//  bool get isLoaded => currentRouteData != null;
//
//  Future<MessagingRouteData> load(String assetsPath) async {
//    var jsonElement = await _loadToJsonElement(assetsPath);
//    _currentRouteData = _resolve(null, jsonElement, null);
//    print("訊息路由解析完成:");
//    var info = _currentRouteData.toString();
//    info.split("\n").forEach((line) => print(line));
//    return _currentRouteData;
//  }
//
//  Future<JsonElement> _loadToJsonElement(String path) async {
//    var extension = path.split(".").last;
//    var content = await rootBundle.loadString(path);
//    JsonElement result;
//    if (extension == "json") {
//      result = JsonElement.fromJsonString(content);
//    } else if (extension == "yaml") {
//      var doc = yaml.loadYaml(content);
//      var jsonString = jsonEncode(doc);
//      result = JsonElement.fromJsonString(jsonString);
//    } else {
//      throw "Unsupported messaging file extension: $extension";
//    }
//    return result;
//  }
//
//  MessagingRouteData _resolve(String key, JsonElement json, MessagingRouteData parent) {
//    if (json.isNull) {
//      return null;
//    } else if (json.isObject) {
//      JsonObject object = json.asObject;
//
//      var data = MessagingRouteData._(
//        message: object.has(_KEY_MESSAGE) && !object[_KEY_MESSAGE].isNull ? object[_KEY_MESSAGE].asString : null,
//        remark: object.has(_KEY_REMARK) && !object[_KEY_REMARK].isNull ? object[_KEY_REMARK].asString : null,
//      );
//      data._parent = parent;
//      data._routes = Map.fromEntries(object[_KEY_ROUTES]?.asObject?.entries?.map((entry) {
//            String key = _parseKey(entry.key);
//            JsonElement value = entry.value;
//            return MapEntry(key, _resolve(key, value, data));
//          }) ??
//          []);
//      return data;
//    } else if (json.isPrimitive) {
//      return MessagingRouteData._(message: json.asString);
//    } else {
//      throw "Illegal state! key=$key json=$json";
//    }
//  }
//}
//
//String _parseKey(String s) => s.replaceAll(r"$", "");
//
//class MessagingRouteData {
//  final String message;
//  final String remark;
//  Map<String, MessagingRouteData> _routes;
//  MessagingRouteData _parent;
//
//  Map<String, MessagingRouteData> get routes => _routes;
//
//  MessagingRouteData get parent => _parent;
//
//  MessagingRouteData._({
//    this.message,
//    this.remark,
//  });
//
//  MessagingRouteData operator [](String routeString) {
//    List<String> routingTraces = routeString.split(".");
//    MessagingRouteData find = this;
//    for (var routingTrace in routingTraces) {
//      routingTrace = _parseKey(routingTrace);
//
//      bool exist = find.routes.containsKey(routingTrace) && find.routes[routingTrace] != null;
//      if (exist) {
//        find = find.routes[routingTrace];
//      } else {
//        while (find != null && find.message == null) {
//          find = find.parent;
//        }
//        break;
//      }
//    }
//    return find;
//  }
//
//  MessagingRouteData find(String routeString) => this[routeString];
//
//  @override
//  String toString() {
//    return JsonElement.fromJsonString(jsonEncode(this)).toJsonString(prettify: true);
//  }
//
//  Map toJson() {
//    var map = {};
//    if (remark != null) map["remark"] = remark;
//    if (message != null) map["message"] = message;
//    if (routes != null && routes.isNotEmpty) map["routes"] = routes;
//    return map;
//  }
//}
