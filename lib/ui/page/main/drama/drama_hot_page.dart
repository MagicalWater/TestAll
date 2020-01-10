import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:media_app/bloc/page/main/drama/drama_hot_bloc.dart';
import 'package:media_app/bloc/page/main/drama_bloc.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/route.dart';
import 'package:media_app/ui/widget/home_grid_list_widget.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/Banner.dart';

@ARoute(url: Pages.dramaHot)
class DramaHotPage extends StatefulWidget {
  final RouteOption option;

  DramaHotPage(this.option) : super();

  @override
  _DramaHotPageState createState() => _DramaHotPageState();
}

class _DramaHotPageState extends State<DramaHotPage> {
  DramaHotBloc bloc;
  DramaBloc dramaBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DramaHotBloc>(context);
    dramaBloc =  BlocProvider.of<DramaBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadProvider(
      loadStream: bloc.loadStream,
      child: PageScaffold(
        haveAppBar: false,
        title: "",
        child: Container(
            child: SliverView(
                stateStream: bloc.sliverStateStream,
                slivers: [_buildBannerSub()] +
                    [_buildGridView()] +
                    [_buildBannerSub()])),
      ),
    );
  }

  /// 建立小橫幅
  Widget _buildBannerSub() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            padding: EdgeInsets.all(Screen.scaleA(10)),
            child: Image.asset(
              Images.icHomeBanner,
              height: Screen.scaleA(63),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  /// 網格視圖列表
  Widget _buildGridView() {
    List datas = bloc.getVideoItems(dramaBloc.tabSelectedField.get());

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var itemData = datas[index];
          return HomeGridListWidget(
            position: index,
            videoGridItem: itemData,
            onPressed: () {
//              _onClickGridItem(context, bloc, itemData.type);
            },
          );
        },
        childCount:  datas.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
      ),
    );
  }

  /// 建立橫幅
  Widget _buildBanner() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          _buildBannerList(),
        ],
      ),
    );
  }

  /// 圖片輪播
  Widget _buildBannerList() {
    return BannerView(
      height: Screen.scaleA(200),
      data: [Images.icHomeBanner2, Images.icHomeBanner2],
      buildShowView: (index, data) {
        return Image.asset(
          data,
          fit: BoxFit.fill,
        );
      },
      onBannerClickListener: (index, data) {},
    );
  }
}
