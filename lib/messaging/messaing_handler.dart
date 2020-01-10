
import 'package:media_app/generated/i18n.dart';
import 'package:media_app_core/messaging/messaging_model.dart';
import 'package:mx_core/extension/toast_extension.dart';
import 'package:mx_core/mx_core.dart';

typedef ErrorHandler = void Function(dynamic, [StackTrace]);

/// 顯示訊息物件吐司條
Future<bool> showToastMessaging(Messaging e) async {
  if (e?.showing != null) return showToast(e.showing);
  return false;
}

/// 顯示字串訊息物件吐司條
Future<bool> showToastMessagingString(String message, [String debugMessage]) {
  return showToastMessaging(StringMessaging(message, debugMessage));
}

/// 顯示錯誤訊息物件吐司條
Future<bool> showToastMessagingError(String errorMessage,
    [StackTrace stackTrace]) {
  return showToastMessaging(ErrorMessaging.of(errorMessage, stackTrace));
}

/// 顯示路由訊息物件吐司條
Future<bool> showToastMessagingRouting([
  dynamic routing1,
  dynamic routing2,
  dynamic routing3,
  dynamic routing4,
  dynamic routing5,
  dynamic routing6,
  dynamic routing7,
  dynamic routing8,
  dynamic routing9,
]) {
  return showToastMessaging(RoutingMessaging.of(
    routing1,
    routing2,
    routing3,
    routing4,
    routing5,
    routing6,
    routing7,
    routing8,
    routing9,
  ));
}

/// 抽象訊息處理器
abstract class MessagingHandler {
  /// 訊息處理抽象接口
  void handle(Messaging messaging);

  /// 全局用錯誤訊息處理器
  static ErrorHandler get errorHandler => (e, [stack]) {
        print("${'=' * 20}handle error${'=' * 20}");

        Messaging messaging;
        if (e is Messaging) {
          print("接收到Messaging錯誤(${e.runtimeType})");
          messaging = e;
          print(messaging.runtimeType);
          if (messaging is RoutingMessaging)
            print("routing=${messaging.routing}");
          if (messaging is ErrorMessaging)
            print(
                "errorMessage=${messaging.errorMessage}, stack=${messaging.stackTrace}");
          if (messaging is StringMessaging)
            print("string=${messaging.showing}");
        } else if (e is HttpError) {
          print("接收到HttpError錯誤(${e.toString()})");
          messaging = StringMessaging(S.current.httpError);
        } else if (e is String) {
          print("接收到String錯誤, 轉換為Messaging");
          messaging = StringMessaging(e);
        } else {
          print("無法解析的錯誤, 轉換為Messaging");
          messaging = ErrorMessaging.of(e?.toString(), stack);
        }
        _GlobalMessagingHandler.getInstance().handle(messaging);
      };

  /// 取得預設全局錯誤處理器
  factory MessagingHandler.global() => _GlobalMessagingHandler.getInstance();
}

/// 實作全局訊息處理器 單例
class _GlobalMessagingHandler implements MessagingHandler {
  static final _GlobalMessagingHandler _instance = _GlobalMessagingHandler._();

  _GlobalMessagingHandler._();

  static _GlobalMessagingHandler getInstance() => _instance;

  @override
  void handle(Messaging messaging) {
    print("debug: ${messaging.debugMessage}");
    if (messaging.extrasInfo != null) print("extras: ${messaging.extrasInfo}");
    showToastMessaging(messaging);
  }
}
