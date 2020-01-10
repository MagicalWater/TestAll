import 'package:flutter/material.dart';
import 'package:media_app/res/images.dart';
import 'package:mx_core/mx_core.dart';

class EmptyBodyWidget extends StatelessWidget {
  final String bodyText;

  EmptyBodyWidget({this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.height * 0.5,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          Image.asset(
//            Images.icNodata,
//            height: Screen.scaleA(150),
//            width: Screen.scaleA(150),
//          ),
//          Container(
//            margin: EdgeInsets.only(
//              top: Screen.scaleA(20),
//            ),
//            child: Text(
//              bodyText ?? S.of(context).noData,
//              style: TextStyle(
//                fontSize: Screen.scaleSp(16),
//                color: DColors.scarlet,
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
