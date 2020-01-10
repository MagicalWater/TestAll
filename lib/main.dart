import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_app/bloc/menu_bloc.dart';
import 'package:media_app/res/colors.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/route_widget.dart';
import 'package:media_app/router/routes.dart';
import 'package:media_app/ui/widget/empty_body_widget.dart';
import 'package:media_app/ui/widget/menu_widget.dart';
import 'package:media_app_core/env/env.dart';
import 'package:media_app_core/messaging/messaging_mapper.dart';
import 'package:mx_core/mx_core.dart';

import 'bloc/application_bloc.dart';
import 'generated/i18n.dart';
import 'main_env.dart';

void main() {
  // 設定基底初始化
  ProjectCore.setting(
    // 設計稿尺寸
    designSize: DesignSize(414, 896, density: 2),

    // 專案擁有的 route
    routeSetting: RouteSetting(
      mixinImpl: ApplicationBloc.getInstance(),
      widgetImpl: RouteWidget.getInstance(),
    ),
  );

  // 設定預設 menu
  PageScaffold.setDefaultMenu((context) {
    return MenuWidget(MenuBloc());
  });

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // 設定預設背景
  PageScaffold.setDefaultBackground(
    linearColors: [DColors.bgColor],
  );

  // 設定列表預設佔位
  SliverView.setDefaultPlace(
    (context, state, place) {
      switch (state) {
        case SliverState.emptyBody:
          return Container(
            color: Colors.white,
            height: Screen.height,
            alignment: Alignment.center,
            child: EmptyBodyWidget(),
          );
        default:
          return null;
      }
    },
  );

  // 全局轉場動畫
  RouteMixin.setDefaultRoute(
    (context, page, name) {
      return PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeTransition(
            opacity: animation,
            child: AxisTransition(
              position: animation,
              child: page,
              slideIn: TransDirection.down,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 600),
      );
    },
  );

  // 設定預設 app bar
  PageScaffold.setDefaultAppBar(
    (BuildContext context, Widget leading, String title, List<Widget> actions) {
      Widget titleWidget = Container(
          child: Image.asset(
        Images.icTitle,
        height: Screen.scaleA(30),
        fit: BoxFit.fill,
      ));

      return AppBar(
        titleSpacing: Screen.scaleA(-10),
        brightness: Brightness.light,
        centerTitle: false,
        flexibleSpace: Container(
          color: Colors.white,
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                if (!Scaffold.hasDrawer(context)) return;
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
                color: Colors.red,
                width: Screen.width,
                height: Screen.scaleA(1),
                alignment: Alignment.center)),
        title: titleWidget,
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: Screen.scaleA(20),
        ),
        actions: actions,
      );
    },
  );
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen.init();
    return LoadProvider(
      root: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: Env.isDebug,
        onGenerateTitle: (context) {
          return appName;
        },
        theme: ThemeData(
          textTheme: TextTheme(
            body1: TextStyle(fontSize: Screen.scaleA(16)),
          ),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate(),
        ],
        localeResolutionCallback: (locale, supports) {
          final _locale = S.delegate.resolution(
              fallback: S.delegate.supportedLocales.first, withCountry: false);
          locale = _locale(locale, supports);
          MessagingMapper.getInstance().load(
              "assets/messaging_handler/messaging_${locale.languageCode}.json");
          ApplicationBloc.currentLocale = locale;
          print("最後語系變更 $locale");

          return locale;
        },
        supportedLocales: S.delegate.supportedLocales,
        home: SafeArea(
          child: ApplicationBloc.getInstance()
              .getPage(Pages.navigation, entryPoint: true),
        ),
      ),
    );
  }
}

/// 為了解決 TextField 長按報錯
/// 看样子和本地化有关,相关解决办法如下，自定义一个本地化代理并添加
class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
