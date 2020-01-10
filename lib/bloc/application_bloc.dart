import 'dart:ui';

import 'package:mx_core/mx_core.dart';

class ApplicationBloc with RouteMixin {
  static final _singleton = ApplicationBloc._internal();

  static ApplicationBloc getInstance() => _singleton;

  factory ApplicationBloc() => _singleton;

  ApplicationBloc._internal();

  /// 系統語系與i18n語系運算後 真正的語系
  static Locale currentLocale;
}

