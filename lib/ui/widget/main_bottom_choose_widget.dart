import 'package:flutter/material.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/MyMaterialView.dart';

import 'main_bottom_widget.dart';

class MainBottomChooseWidget extends StatelessWidget {
  final List<BottomChildItem> childItem;
  final Function(BottomChildItem selectData) onItemTap;

  /// 下方導覽列第二層
  MainBottomChooseWidget({
    @required this.childItem,
    @required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> childItemsWidget = childItem
        .map(
          (o) => MyMaterialView(
            padding: EdgeInsets.symmetric(horizontal: Screen.scaleA(15)),
            child: Text(
              o.title,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onItemTap(o),
          ),
        )
        .toList();
    return Container(
      width: Screen.width,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: childItemsWidget,
        ),
      ),
    );
  }
}
