import 'package:media_app/res/colors.dart';
import 'package:mx_core/mx_core.dart';
import 'package:flutter/material.dart';

enum LinearGradientDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  leftTopToRightBottom,
  leftBottomToRightTop,
  rightTopToLeftBottom,
  rightBottomToLeftTop,
}

AlignmentGeometry _parseBegin(LinearGradientDirection direction) {
  switch (direction) {
    case LinearGradientDirection.leftToRight:
      return Alignment.centerLeft;
    case LinearGradientDirection.rightToLeft:
      return Alignment.centerRight;
    case LinearGradientDirection.topToBottom:
      return Alignment.topCenter;
    case LinearGradientDirection.bottomToTop:
      return Alignment.bottomCenter;
    case LinearGradientDirection.leftTopToRightBottom:
      return Alignment.topLeft;
    case LinearGradientDirection.leftBottomToRightTop:
      return Alignment.bottomLeft;
    case LinearGradientDirection.rightTopToLeftBottom:
      return Alignment.topRight;
    case LinearGradientDirection.rightBottomToLeftTop:
      return Alignment.bottomRight;
  }
  throw "illegal direction";
}

AlignmentGeometry _parseEnd(LinearGradientDirection direction) {
  switch (direction) {
    case LinearGradientDirection.leftToRight:
      return Alignment.centerRight;
    case LinearGradientDirection.rightToLeft:
      return Alignment.centerLeft;
    case LinearGradientDirection.topToBottom:
      return Alignment.bottomCenter;
    case LinearGradientDirection.bottomToTop:
      return Alignment.topCenter;
    case LinearGradientDirection.leftTopToRightBottom:
      return Alignment.bottomRight;
    case LinearGradientDirection.leftBottomToRightTop:
      return Alignment.topRight;
    case LinearGradientDirection.rightTopToLeftBottom:
      return Alignment.bottomLeft;
    case LinearGradientDirection.rightBottomToLeftTop:
      return Alignment.topLeft;
  }
  throw "illegal direction";
}

/// 漸層按鈕
class GradientButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;

  final Gradient gradientColor;
  final VoidCallback onTap;
  final List<Color> colors;
  final LinearGradientDirection gradientDirection;

  GradientButton(
    this.text, {
    this.textColor = Colors.white,
    this.fontSize,
    this.margin,
    this.padding,
    this.gradientColor,
    this.onTap,
    this.colors = const [DColors.wheat, DColors.coralPink],
    this.gradientDirection = LinearGradientDirection.topToBottom,
  });

  List<Color> get _effectiveColors {
    if (colors == null || colors.isEmpty)
      return [Colors.black, Colors.black];
    else if (colors.length == 1) return [colors.single, colors.single];
    return colors;
  }

  Gradient get _effectiveGradient {
    return gradientColor ??
        LinearGradient(
          colors: _effectiveColors,
          begin: _parseBegin(gradientDirection),
          end: _parseEnd(gradientDirection),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialLayer(
      layers: [
        LayerProperties(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Screen.scaleA(5),
            ),
            gradient: _effectiveGradient,
          ),
        ),
      ],
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: Screen.scaleA(8), horizontal: Screen.scaleA(50)),
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
