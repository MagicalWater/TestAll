import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/drama_bloc.dart';
import 'package:media_app/generated/i18n.dart';
import 'package:media_app/res/colors.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/ui/widget/text_segment_widget.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/MyAttrView.dart';

@ARoute(url: Pages.drama)
class DramaPage extends StatefulWidget {
  final RouteOption option;

  DramaPage(this.option) : super();

  @override
  _DramaPageState createState() => _DramaPageState();
}

class _DramaPageState extends State<DramaPage> {
  DramaBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DramaBloc>(context);

    if (bloc.tabItems.isNotEmpty) {
      bloc.tabSelectedField.set(bloc.tabItems[0].tabName);
      bloc.setSubPage(bloc.tabItems[0].routeName);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: false,
        title: "",
        child: Column(
          children: <Widget>[
            _buildTop(),
            Expanded(
              child: _buildPage(),
            ),
          ],
        ),
      ),
    );
  }

  /// 首頁上方的Banner輪播圖片及跑馬燈
  Widget _buildTop() {
    return Container(
      color: DColors.lightGeryBg,
      child: Row(
        children: <Widget>[
          SizedBox(width: Screen.scaleA(10)),
          MyAttrView(
            text: S.of(context).filter,
            textSize: Screen.scaleA(15),
            imgFileLeft: Images.icFunnel,
            iconMargin: EdgeInsets.only(left: Screen.scaleA(5)),
            onPressed: () {},
          ),
          SizedBox(width: 10),
          Container(
            color: DColors.geryLine,
            height: Screen.scaleA(20),
            width: Screen.scaleA(1),
          ),
          Expanded(child: _buildTabs()),
        ],
      ),
    );
  }

  /// 頁籤
  Widget _buildTabs() {
    bloc.setSubPage(bloc.tabItems[0].tabName);
    return StreamBuilder<String>(
      stream: bloc.tabSelectedField.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        var routeData = snapshot.data;

        return TextSegmentWidget(
          items: bloc.tabItems,
          selectTabName: routeData,
          onItemTap: (context, index) {
            bloc.tabSelectedField.set(bloc.tabItems[index].tabName);
            bloc.setSubPage(bloc.tabItems[index].routeName);
          },
        );
      },
    );
  }

  /// 切換內容頁
  Widget _buildPage() {
    return PageSwitcher(
      stream: bloc.subPageStream,
    );
  }
}
