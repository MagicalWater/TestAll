import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/drama_bloc.dart';
import 'package:media_app/res/colors.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/MyMaterialView.dart';

class TextSegmentWidget extends StatelessWidget {
  final String selectTabName;
  final List<TabItem> items;
  final double itemSpace;
  final Function(BuildContext context, int index) onItemTap;

  TextSegmentWidget({
    @required this.items,
    @required this.selectTabName,
    this.itemSpace = 0,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildWidgetList(context),
        ),
      ),
    );
  }

  List<Widget> _buildWidgetList(BuildContext context) {
    // 穿插空格,所以總數是item * 2 - 1
    var widgetCount = items.length * 2 - 1;

    return List.generate(widgetCount, (index) {
      // 奇數為空格,偶數為item
      if (index.isEven) {
        // ~/取得整除數,例 7 ~/ 2 = 3
        var itemIndex = index ~/ 2;
        return _buildTabWidget(context, itemIndex);
      } else {
        return Container(
          width: itemSpace,
        );
      }
    });
  }

  Widget _buildTabWidget(BuildContext context, int index) {
    var isSelected = items[index].tabName == selectTabName ||
        items[index].tabName.contains(selectTabName);

    return MaterialLayer(
      child: Align(
        heightFactor: 1,
        child: Center(
          child: MyMaterialView(
            radius: BorderRadius.all(Radius.circular(5)),
            margin: EdgeInsets.symmetric(horizontal: Screen.scaleA(10), vertical:Screen.scaleA( 10)),
            backgroundColor:
                isSelected ? DColors.pinkSelectedTab : Colors.transparent,
            padding: EdgeInsets.all(
              Screen.scaleA(5),
            ),
            child: Text(
              items[index].title,
              style: TextStyle(
                fontSize: Screen.scaleSp(16),
                color: DColors.textDarkGrey,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        if (onItemTap != null) {
          onItemTap(context, index);
        }
      },
    );
  }
}
