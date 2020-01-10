import 'package:flutter/widgets.dart';
import 'package:media_app/bloc/page/main/home_bloc.dart';
import 'package:media_app_core/bloc/page/ex_home_bloc.dart';
import 'package:media_app_core/bloc/page/ex_launch_bloc.dart';
import 'package:mx_core/mx_core.dart';
import 'route.dart';
import 'package:media_app/bloc/page/ex_launch/ex_sub_launch_bloc.dart';
import 'package:media_app/bloc/page/ex_home/ex_sub_home_bloc.dart';
import 'package:media_app/bloc/page/ex_home/ex_sub_home/ex_sub_sub_home_bloc.dart';
import 'package:media_app/bloc/page/navigation_bloc.dart';
import 'package:media_app/bloc/page/main_bloc.dart';
import 'package:media_app/bloc/page/main/cartoon_bloc.dart';
import 'package:media_app/bloc/page/main/adult_video_bloc.dart';
import 'package:media_app/bloc/page/main/drama_bloc.dart';
import 'package:media_app/bloc/page/main/movie_bloc.dart';
import 'package:media_app/bloc/page/main/variety_show_bloc.dart';
import 'package:media_app/bloc/page/main/drama/drama_new_bloc.dart';
import 'package:media_app/bloc/page/main/drama/drama_hot_bloc.dart';

/// 儲存所有 route 對應的 page widget
class RouteWidget implements RouteWidgetBase {
  static final _singleton = RouteWidget._internal();

  static RouteWidget getInstance() => _singleton;

  factory RouteWidget() => _singleton;

  RouteWidget._internal();

  @override
  List<String> pageList = [
    Pages.exLaunch,
    Pages.exHome,
    Pages.exSubLaunch,
    Pages.exSubHome,
    Pages.exSubSubHome,
    Pages.navigation,
    Pages.main,
    Pages.cartoon,
    Pages.adultVideo,
    Pages.drama,
    Pages.movie,
    Pages.varietyShow,
    Pages.dramaNew,
    Pages.dramaHot,
    Pages.home,
  ];

  @override
  Widget getPage(RouteData data) {
    final widgetOption = data.copyWith(RouteDataType.widget);
    final blocOption = data.copyWith(RouteDataType.bloc);
    final child = AppRoute.getPage(widgetOption);
    switch (data.route) {
      case Pages.exLaunch:
        return BlocProvider(
          child: child,
          bloc: ExLaunchBloc(blocOption),
        );
      case Pages.exHome:
        return BlocProvider(
          child: child,
          bloc: ExHomeBloc(blocOption),
        );
      case Pages.exSubLaunch:
        return BlocProvider(
          child: child,
          bloc: ExSubLaunchBloc(blocOption),
        );
      case Pages.exSubHome:
        return BlocProvider(
          child: child,
          bloc: ExSubHomeBloc(blocOption),
        );
      case Pages.exSubSubHome:
        return BlocProvider(
          child: child,
          bloc: ExSubSubHomeBloc(blocOption),
        );
      case Pages.navigation:
        return BlocProvider(
          child: child,
          bloc: NavigationBloc(blocOption),
        );
      case Pages.main:
        return BlocProvider(
          child: child,
          bloc: MainBloc(blocOption),
        );

      case Pages.cartoon:
        return BlocProvider(
          child: child,
          bloc: CartoonBloc(blocOption),
        );
      case Pages.adultVideo:
        return BlocProvider(
          child: child,
          bloc: AdultVideoBloc(blocOption),
        );
      case Pages.drama:
        return BlocProvider(
          child: child,
          bloc: DramaBloc(blocOption),
        );
      case Pages.movie:
        return BlocProvider(
          child: child,
          bloc: MovieBloc(blocOption),
        );
      case Pages.varietyShow:
        return BlocProvider(
          child: child,
          bloc: VarietyShowBloc(blocOption),
        );
      case Pages.dramaNew:
        return BlocProvider(
          child: child,
          bloc: DramaNewBloc(blocOption),
        );
      case Pages.dramaHot:
        return BlocProvider(
          child: child,
          bloc: DramaHotBloc(blocOption),
        );
      case Pages.home:
        return BlocProvider(
          child: child,
          bloc: HomeBloc(blocOption),
        );
      default:
        print("找無對應的 page, ${data.route}");
        return null;
    }
  }
}
