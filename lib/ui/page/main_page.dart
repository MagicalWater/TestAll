import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main_bloc.dart';
import 'package:media_app/res/colors.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/ui/widget/main_bottom_choose_widget.dart';
import 'package:media_app/ui/widget/main_bottom_widget.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/ImageRippleView.dart';

@ARoute(url: Pages.main)
class MainPage extends StatefulWidget {
  final RouteOption option;

  MainPage(this.option) : super();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MainBloc>(context);
    bloc.setSubPage(Pages.home);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 搜尋按鈕
    final searchBtn = Center(
      child: ImageRippleView(
        padding: EdgeInsets.only(
            right: Screen.scaleSp(10), left: Screen.scaleSp(10)),
        image: Image.asset(
          Images.icSearch,
          width: Screen.scaleA(30),
          height: Screen.scaleA(30),
        ),
        onPressed: () {},
      ),
    );

    // 會員按鈕
    final userBtn = Center(
      child: ImageRippleView(
        padding: EdgeInsets.only(
            right: Screen.scaleSp(10), left: Screen.scaleSp(10)),
        image: Image.asset(
          Images.icUser,
          width: Screen.scaleA(30),
          height: Screen.scaleA(30),
        ),
        onPressed: () {},
      ),
    );

    // 首頁按鈕
    final homeBtn = Center(
      child: ImageRippleView(
        padding: EdgeInsets.only(
            right: Screen.scaleSp(10), left: Screen.scaleSp(10)),
        image: Image.asset(
          Images.icHome,
          width: Screen.scaleA(30),
          height: Screen.scaleA(30),
        ),
        onPressed: () {},
      ),
    );

    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: true,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: buildPage(),
              ),
              initBottomView(),
            ],
          ),
        ),
        actions: <Widget>[
          searchBtn,
          userBtn,
          homeBtn,
        ],
      ),
    );
  }

  /// 切換中間頁
  Widget buildPage() {
    return StreamBuilder<RouteData>(
      stream: bloc.subPageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Stack(
          children: <Widget>[
            PageSwitcher(
              stream: bloc.subPageStream,
            )
          ],
        );
      },
    );
  }

  /// 下方導覽列
  Widget initBottomView() {
    return StreamBuilder<RouteData>(
      stream: bloc.subPageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        var routeData = snapshot.data;

        return Material(
          elevation: Screen.scaleA(10),
          child: Container(
            height: Screen.scaleA(62),
            color: Colors.white,
            child: MainBottomWidget(
              items: bloc.bottomItem,
              selectRouteName: routeData.route,
              selectColor: DColors.redBottomView,
              iconSize: Screen.scaleA(24),
              onItemTap: (context, index) {
                if (bloc.bottomItem[index].childItem.isNotEmpty) {
                  showArrowPopup(
                    context,
                    color: Colors.black.withOpacity(0.85),
                    radius: 0,
                    offset: Offset(0, Screen.scaleA(-16)),
                    arrowTargetPercent: Screen.scaleA(0.5),
                    arrowSize: Screen.scaleA(10),
                    arrowRootSize: Screen.scaleA(18),
                    arrowSide: ArrowSide.line,
                    direction: AxisDirection.up,
                    builder: (context, popController) {
                      return MainBottomChooseWidget(
                        childItem: bloc.bottomItem[index].childItem,
                        onItemTap: (selectData) {
                          popController.remove();
                          bloc.setSubPage(selectData.routeName);
                        },
                      );
                    },
                  );
                } else {
                  bloc.setSubPage(bloc.bottomItem[index].routeName);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
