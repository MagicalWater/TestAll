// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteWriterGenerator
// **************************************************************************

import 'dart:convert';
import 'package:annotation_route/route.dart';
import 'package:media_app/ui/page/main_page.dart';
import 'package:media_app/ui/page/ex_launch_page.dart';
import 'package:media_app/ui/page/navigation_page.dart';
import 'package:media_app/ui/page/ex_home_page.dart';
import 'package:media_app/ui/page/main/cartoon_page.dart';
import 'package:media_app/ui/page/main/drama_page.dart';
import 'package:media_app/ui/page/main/variety_show_page.dart';
import 'package:media_app/ui/page/main/adult_video_page.dart';
import 'package:media_app/ui/page/main/movie_page.dart';
import 'package:media_app/ui/page/main/drama/drama_hot_page.dart';
import 'package:media_app/ui/page/main/drama/drama_new_page.dart';
import 'package:media_app/ui/page/ex_home/ex_sub_home/ex_sub_sub_home_page.dart';
import 'package:media_app/ui/page/ex_home/ex_sub_home_page.dart';
import 'package:media_app/ui/page/ex_launch/ex_sub_launch_page.dart';
import 'package:media_app/ui/page/main/home_page.dart';

class ARouterInternalImpl extends ARouterInternal {
  ARouterInternalImpl();
  final Map<String, List<Map<String, dynamic>>> innerRouterMap =
      <String, List<Map<String, dynamic>>>{
    '/main': [
      {'clazz': MainPage}
    ],
    '/exLaunch': [
      {'clazz': ExLaunchPage}
    ],
    '/navigation': [
      {'clazz': NavigationPage}
    ],
    '/exHome': [
      {'clazz': ExHomePage}
    ],
    '/main/cartoon': [
      {'clazz': CartoonPage}
    ],
    '/main/drama': [
      {'clazz': DramaPage}
    ],
    '/main/varietyShow': [
      {'clazz': VarietyShowPage}
    ],
    '/main/adultVideo': [
      {'clazz': AdultVideoPage}
    ],
    '/main/movie': [
      {'clazz': MoviePage}
    ],
    '/main/drama/dramaHot': [
      {'clazz': DramaHotPage}
    ],
    '/main/drama/dramaNew': [
      {'clazz': DramaNewPage}
    ],
    '/exHome/exSubHome/exSubSubHome': [
      {'clazz': ExSubSubHomePage}
    ],
    '/exHome/exSubHome': [
      {'clazz': ExSubHomePage}
    ],
    '/exLaunch/exSubLaunch': [
      {'clazz': ExSubLaunchPage}
    ],
    '/main/home': [
      {'clazz': HomePage}
    ]
  };

  @override
  bool hasPageConfig(ARouteOption option) {
    final dynamic pageConfig = findPageConfig(option);
    return pageConfig != null;
  }

  @override
  ARouterResult findPage(ARouteOption option, dynamic initOption) {
    final dynamic pageConfig = findPageConfig(option);
    if (pageConfig != null) {
      return implFromPageConfig(pageConfig, initOption);
    } else {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
  }

  void instanceCreated(
      dynamic clazzInstance, Map<String, dynamic> pageConfig) {}

  dynamic instanceFromClazz(Type clazz, dynamic option) {
    switch (clazz) {
      case MainPage:
        return new MainPage(option);
      case ExLaunchPage:
        return new ExLaunchPage(option);
      case NavigationPage:
        return new NavigationPage(option);
      case ExHomePage:
        return new ExHomePage(option);
      case CartoonPage:
        return new CartoonPage(option);
      case DramaPage:
        return new DramaPage(option);
      case VarietyShowPage:
        return new VarietyShowPage(option);
      case AdultVideoPage:
        return new AdultVideoPage(option);
      case MoviePage:
        return new MoviePage(option);
      case DramaHotPage:
        return new DramaHotPage(option);
      case DramaNewPage:
        return new DramaNewPage(option);
      case ExSubSubHomePage:
        return new ExSubSubHomePage(option);
      case ExSubHomePage:
        return new ExSubHomePage(option);
      case ExSubLaunchPage:
        return new ExSubLaunchPage(option);
      case HomePage:
        return new HomePage(option);
      default:
        return null;
    }
  }

  ARouterResult implFromPageConfig(
      Map<String, dynamic> pageConfig, dynamic option) {
    final String interceptor = pageConfig['interceptor'];
    if (interceptor != null) {
      return ARouterResult(
          state: ARouterResultState.REDIRECT, interceptor: interceptor);
    }
    final Type clazz = pageConfig['clazz'];
    if (clazz == null) {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
    try {
      final dynamic clazzInstance = instanceFromClazz(clazz, option);
      instanceCreated(clazzInstance, pageConfig);
      return ARouterResult(
          widget: clazzInstance, state: ARouterResultState.FOUND);
    } catch (e) {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
  }

  dynamic findPageConfig(ARouteOption option) {
    final List<Map<String, dynamic>> pageConfigList =
        innerRouterMap[option.urlpattern];
    if (null != pageConfigList) {
      for (int i = 0; i < pageConfigList.length; i++) {
        final Map<String, dynamic> pageConfig = pageConfigList[i];
        final String paramsString = pageConfig['params'];
        if (null != paramsString) {
          Map<String, dynamic> params;
          try {
            params = json.decode(paramsString);
          } catch (e) {
            print('not found A{pageConfig};');
          }
          if (null != params) {
            bool match = true;
            final Function matchParams = (String k, dynamic v) {
              if (params[k] != option?.params[k]) {
                match = false;
                print('not match:A{params[k]}:A{option?.params[k]}');
              }
            };
            params.forEach(matchParams);
            if (match) {
              return pageConfig;
            }
          } else {
            print('ERROR: in parsing paramsA{pageConfig}');
          }
        } else {
          return pageConfig;
        }
      }
    }
    return null;
  }
}
