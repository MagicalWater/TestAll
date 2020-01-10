import 'package:media_app/generated/i18n.dart';
import 'package:media_app/res/images.dart';
import 'package:media_app/router/route.dart';
import 'package:mx_core/mx_core.dart';

class DramaHotBloc extends PageBloc {
  DramaHotBloc(RouteOption option) : super(Pages.dramaHot, option);

  List<VideoGridItem> getVideoItems (String typeName){
    return typeName=="1"?fakeVideoGridItems:fakeVideoGridItems2;
  }

  List<VideoGridItem> fakeVideoGridItems = [
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome),

  ];

  List<VideoGridItem> fakeVideoGridItems2 = [
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),
    VideoGridItem(
        title: S.current.videoTitleEx,
        subTitle: S.current.videoSubTitleEx,
        imgUrl: Images.icWelcome2),

  ];
}

class VideoGridItem {
  final String imgUrl;
  final String title;
  final String subTitle;

  VideoGridItem({
    this.imgUrl,
    this.title,
    this.subTitle,
  });
}
