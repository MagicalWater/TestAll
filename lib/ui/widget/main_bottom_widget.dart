import 'package:flutter/material.dart';
import 'package:media_app/res/colors.dart';
import 'package:mx_core/mx_core.dart';

/// 首頁下方導覽按鈕
class MainBottomWidget extends StatelessWidget {
  final String selectRouteName;
  final List<BottomItem> items;
  final double itemSpace;
  final Function(BuildContext context, int index) onItemTap;
  final Color backgroundColor;
  final Color color;
  final Color selectColor;
  final double iconSize;

  MainBottomWidget({
    @required this.items,
    @required this.selectRouteName,
    this.itemSpace = 0,
    this.onItemTap,
    this.backgroundColor,
    this.color,
    this.selectColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Row(
        children: _buildWidgetList(context),
      ),
    );
  }

  List<Widget> _buildWidgetList(BuildContext context) {
    var widgetCount = items.length * 2 - 1;

    return List.generate(widgetCount, (index) {
      if (index.isEven) {
        var itemIndex = index ~/ 2;
        return Expanded(
          flex: 1,
          child: _buildTabWidget(itemIndex, context),
        );
      } else {
        return Container(
          width: itemSpace,
        );
      }
    });
  }

  Widget _buildTabWidget(int index, BuildContext context) {
    var isSelected = items[index].contains(selectRouteName) || items[index].routeName == selectRouteName;

    if (items[index].icon.isEmpty && items[index].iconSelect.isEmpty && items[index].text.isEmpty) {
      return Container();
    }

    return Builder(
      builder: (context) {
        return MaterialLayer(
          onTap: () {
            if (onItemTap != null) {
              onItemTap(context, index);
            }
          },
          child: Align(
            heightFactor: 1,
            child: Center(
              child: Column(
                key: items[index].key,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: Screen.scaleA(10),
                      bottom: Screen.scaleA(3),
                    ),
                    child: Image.asset(
                      isSelected ? items[index].iconSelect : items[index].icon,
                      height: iconSize,
                      width: iconSize,
                      color: isSelected ? Colors.red : Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[index].text,
                      style: TextStyle(
                        fontSize: Screen.scaleSp(14),
                        color: isSelected ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: Screen.scaleA(2),
                    width: Screen.scaleA(55),
                    color: isSelected ? selectColor : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomItem {
  final Key key;
  final String icon;
  final String iconSelect;
  final String text;
  final String routeName;
  final List<BottomChildItem> childItem;

  bool contains(String route) => childItem.any((b) => b.routeName.contains(route));

  BottomItem.parent({
    this.key,
    this.icon,
    this.iconSelect,
    this.text,
    this.routeName,
  }) : this.childItem = [];

  BottomItem.child({
    this.key,
    this.icon,
    this.iconSelect,
    this.text,
    this.childItem,
  }) : this.routeName = "";
}

class BottomChildItem {
  final String title;
  final String routeName;

  BottomChildItem({
    this.title,
    this.routeName,
  });
}
