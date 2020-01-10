import 'package:flutter/material.dart';
import 'package:media_app/generated/i18n.dart';
import 'package:media_app_core/databinding/observable_field.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';

class DramaBloc extends PageBloc {
  DramaBloc(RouteOption option) : super(Pages.drama, option);

  ObservableField<String> tabSelectedField = ObservableField.ofString();

  List<TabItem> tabItems = [
    TabItem(
        title: S.current.topRanking, routeName: Pages.dramaHot, tabName: "1"),
    TabItem(
        title: S.current.newArrival, routeName: Pages.dramaHot, tabName: "2"),
    TabItem(
        title: S.current.lastestRelease,
        routeName: Pages.dramaHot,
        tabName: "3"),
    TabItem(
        title: S.current.topRanking, routeName: Pages.dramaHot, tabName: "4"),
    TabItem(
        title: S.current.newArrival, routeName: Pages.dramaHot, tabName: "5"),
    TabItem(
        title: S.current.lastestRelease,
        routeName: Pages.dramaHot,
        tabName: "6"),
  ];

  @override
  void dispose() {
    super.dispose();
  }
}

/// tab物件
class TabItem {
  /// 顯示名稱
  @required
  String title;

  /// 子頁routeName
  @required
  String routeName;

  /// 子頁面命名
  @required
  String tabName;

  TabItem({this.title, this.routeName, this.tabName});
}
