import 'package:flutter/material.dart';
import 'package:media_app/generated/i18n.dart';

/// 多國語言調用工具, 由此調用 S, 並且暫時緩存

S _tempS = S();

/// 多國語係實例
/// Localization Instance
S get li => _tempS;

class L {
  /// 初始化 _tempS
  static init(BuildContext context) {
    _tempS = Localizations.of<S>(context, S);
  }

  static S of(BuildContext context) {
    final s = Localizations.of<S>(context, S);
    _tempS = s;
    return s;
  }
}
