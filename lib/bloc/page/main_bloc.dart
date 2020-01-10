import 'package:media_app/generated/i18n.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/ui/widget/main_bottom_widget.dart';
import 'package:mx_core/mx_core.dart';
import 'package:media_app/router/route.dart';

class MainBloc extends PageBloc {
  MainBloc(RouteOption option) : super(Pages.main, option);

  /// 導覽列物件
  List<BottomItem> bottomItem = <BottomItem>[
    BottomItem.parent(
      text: S.current.dramaTitle,
      icon: Images.icDrama,
      iconSelect: Images.icDrama,
      routeName: Pages.drama,
    ),
    BottomItem.parent(
      text: S.current.movieTitle,
      icon: Images.icMovie,
      iconSelect: Images.icMovie,
      routeName: Pages.movie,
    ),
    BottomItem.parent(
      text: S.current.varietyShowTitle,
      icon: Images.icVarietyShow,
      iconSelect: Images.icVarietyShow,
      routeName: Pages.varietyShow,
    ),
    BottomItem.parent(
      text: S.current.cartoonTitle,
      icon: Images.icCartoon,
      iconSelect: Images.icCartoon,
      routeName: Pages.cartoon,
    ),
    BottomItem.child(
      text: S.current.adultVideoTitle,
      icon: Images.icAdultVideo,
      iconSelect: Images.icAdultVideo,
      childItem: [
        BottomChildItem(title: S.current.longVideo, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.shortVideo, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.selfie, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.photo, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.comic, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.literature, routeName: Pages.adultVideo),
        BottomChildItem(title: S.current.storytelling, routeName: Pages.adultVideo),
      ],
    ),
  ];
}
