import 'dart:async';
import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/navigation_bloc.dart';
import 'package:media_app/messaging/messaing_handler.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/routes.dart';
import 'package:media_app/ui/dialog/update_version_dialog.dart';
import 'package:mx_core/mx_core.dart';

@ARoute(url: Pages.navigation)
class NavigationPage extends StatefulWidget {
  final RouteOption option;

  NavigationPage(this.option) : super();

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationBloc bloc;

  StreamSubscription needToAutoLoginSubscription;

  @override
  void initState() {
    bloc = BlocProvider.of<NavigationBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.pushPage(Pages.main, context, replaceCurrent: true);
    });

    // 檢查版本
//    bloc.checkUpdate()
//        .doOnListen(() => bloc.setLoadState(true))
//        .doOnDone(() => bloc.setLoadState(false))
//        .listen((data) {
//      if (data != null) {
//        // 若需要更新則顯示dialog
//        showDialog(
//          context: context,
//          barrierDismissible: false,
//          builder: (context) {
//            return UpdateVersionDialog(data);
//          },
//        );
//      } else {
//        // 若回傳null, 不需要更新跳轉到main頁
//        bloc.pushPage(Pages.main, context, replaceCurrent: true);
//      }
//    }).onError(MessagingHandler.errorHandler);
    super.initState();
  }

  @override
  void dispose() {
    needToAutoLoginSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: false,
        title: "",
        background: Image.asset(
          Images.icWelcome,
          fit: BoxFit.fill,
        ),
        child: Container(),
      ),
    );
  }
}
