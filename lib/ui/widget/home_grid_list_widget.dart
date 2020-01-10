import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/drama/drama_hot_bloc.dart';
import 'package:media_app/generated/i18n.dart';
import 'package:media_app/res/colors.dart';
import 'package:media_app/res/images.dart';
import 'package:mx_core/mx_core.dart';

import 'package:xview/widget/MyAttrView.dart';
import 'package:xview/xview.dart';

///首頁 List Item
class HomeGridListWidget extends StatelessWidget {
  HomeGridListWidget(
      {this.position, this.videoGridItem, this.onPressed}) //this.data,
      : super(); //this.pageDatas,

//  final List<String> pageDatas;
  final int position;

  final VideoGridItem videoGridItem;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MyMaterialView(
      padding: EdgeInsets.symmetric(
          horizontal: Screen.scaleA(10), vertical: Screen.scaleA(10)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Image.asset(
              videoGridItem.imgUrl,
              fit: BoxFit.fill,
            )),
            Text(
              videoGridItem.title,
              style: TextStyle(
                  color: DColors.blackText, fontSize: Screen.scaleSp(16)),
            ),
            Text(
              videoGridItem.subTitle,
              style: TextStyle(
                  color: DColors.brownGreyTwo, fontSize: Screen.scaleSp(14)),
            )
          ]),
      onPressed: onPressed,
    );
  }
}
