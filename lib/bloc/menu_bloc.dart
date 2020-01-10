import 'package:media_app/generated/i18n.dart';
import 'package:media_app/router/routes.dart';
import 'package:media_app_core/databinding/observable_field.dart';
import 'package:mx_core/mx_core.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc {
  MenuBloc() {
    FileUtil.cacheFileSize.then((data) => cacheFileSizeField.set(data));
  }

  /// 清理緩存流
  ObservableField<double> cacheFileSizeField = ObservableField.ofDouble();

  ObservableField<int> selectedMenuIndex = ObservableField.ofInt();

  /// 側選單列表
  List<MenuItem> menuItem = [
    MenuItem(title: S.current.homePage, routeName: Pages.home),
    MenuItem(title: S.current.dramaTitle, routeName: Pages.drama),
    MenuItem(title:  S.current.movieTitle, routeName: Pages.movie),
    MenuItem(title:  S.current.varietyShowTitle, routeName: Pages.varietyShow),
    MenuItem(title:  S.current.cartoonTitle, routeName: Pages.cartoon),
    MenuItem(title:  S.current.adultVideoTitle, childItem: [
      MenuChildItem(title:  S.current.longVideo, routeName: Pages.adultVideo),
      MenuChildItem(title:  S.current.shortVideo, routeName: Pages.adultVideo),
      MenuChildItem(title:  S.current.selfie, routeName: Pages.adultVideo),
      MenuChildItem(title:  S.current.photo, routeName: Pages.adultVideo),
      MenuChildItem(title:  S.current.comic, routeName: Pages.adultVideo),
      MenuChildItem(title:  S.current.literature, routeName: Pages.adultVideo),
      MenuChildItem(title: S.current.storytelling, routeName: Pages.adultVideo),
    ]),
    MenuItem(title: S.current.leaderBoard, routeName: Pages.drama),
    MenuItem(title: S.current.aboutShake, routeName: Pages.drama)
  ];

  /// Widget dispose時觸發
  void dispose() {
    cacheFileSizeField.close();
  }
}

/// 側選單物件
class MenuItem {
  final String title;
  final List<MenuChildItem> childItem;
  final String routeName;

  MenuItem({
    this.title,
    this.routeName,
    this.childItem = const [],
  });
}

/// 側選單展開子Item物件
class MenuChildItem {
  final String title;
  final String routeName;

  MenuChildItem({this.title, this.routeName});
}
