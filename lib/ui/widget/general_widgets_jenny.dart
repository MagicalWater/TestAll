import 'package:flutter/material.dart';
import 'package:media_app/res/colors.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/xview.dart';

/// icon文字圓角按鈕
class MyIconTextButtonWidget extends StatelessWidget {
  final String text;
  final String icon;
  final Color borderColor;
  final VoidCallback onPressed;

  MyIconTextButtonWidget(this.text, this.icon, {this.borderColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MyAttrView(
      padding: EdgeInsets.only(
        left: Screen.scaleA(12),
        right: Screen.scaleA(12),
        top: Screen.scaleA(8),
        bottom: Screen.scaleA(8),
      ),
      text: text,
      imgFileLeft: icon,
      iconMargin: EdgeInsets.only(
        left: Screen.scaleA(10),
      ),
      backgroundColor: Colors.white,
      borderWidth: Screen.scaleA(1),
      borderColor: borderColor ?? DColors.whiteTwo,
      radius: BorderRadius.circular(
        Screen.scaleA(3),
      ),
      onPressed: onPressed,
    );
  }
}

/// 漸層按鈕
class MyGradientButtonWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Gradient gradientColor;
  final Color shadowColor;
  final VoidCallback onTap;

  MyGradientButtonWidget(
    this.text, {
    this.textColor = Colors.white,
    this.fontSize,
    this.margin,
    this.padding,
    this.gradientColor = DColors.generalGradientBg,
    this.shadowColor = DColors.rosyPink54,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialLayer(
      layers: [
        LayerProperties(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Screen.scaleA(6),
            ),
            gradient: gradientColor,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: Screen.scaleA(4),
                offset: Offset(0, 2),
              )
            ],
          ),
        ),
      ],
      child: Container(
        padding: padding ??
            EdgeInsets.only(
              top: Screen.scaleA(10),
              bottom: Screen.scaleA(10),
              left: Screen.scaleA(25),
              right: Screen.scaleA(25),
            ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize ?? Screen.scaleSp(16),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
