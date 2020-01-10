import 'package:flutter/material.dart';
import 'package:media_app/bloc/application_bloc.dart';
import 'package:media_app/bloc/menu_bloc.dart';
import 'package:media_app/generated/i18n.dart';
import 'package:media_app/res/colors.dart';
import 'package:media_app/res/images.dart';
import 'package:mx_core/mx_core.dart';
import 'package:xview/widget/ImageRippleView.dart';
import 'package:xview/widget/MyAttrView.dart';
import 'package:xview/widget/MyMaterialView.dart';

/// 側選單
class MenuWidget extends StatefulWidget {
  MenuWidget(this.bloc) : super();
  final MenuBloc bloc;

  @override
  _MenuWidgetState createState() => _MenuWidgetState(bloc);
}

class _MenuWidgetState extends State<MenuWidget> {
  final MenuBloc bloc;

  _MenuWidgetState(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.white,
          width: Screen.scaleA(270),
          child: Column(
            children: <Widget>[
              SizedBox(height: Screen.scaleA(20)),
              // 關閉按鈕
              MyMaterialView(
                padding: EdgeInsets.symmetric(horizontal: Screen.scaleA(27), vertical: Screen.scaleA(20)),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  Images.icClose,
                  height: Screen.scaleA(20),
                  width: Screen.scaleA(20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              // 頭像
              Image.asset(
                Images.icUserHead,
                width: Screen.scaleA(65),
                height: Screen.scaleA(65),
              ),
              SizedBox(height: Screen.scaleA(10)),
              // 會員登入 / 注册
              MyAttrView(
                padding: EdgeInsets.symmetric(horizontal: Screen.scaleA(30), vertical: Screen.scaleA(10)),
                text: S.of(context).loginAndSignup,
                borderWidth: 1,
                borderColor: Colors.grey,
                radius: BorderRadius.all(Radius.circular(5)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: Screen.scaleA(20)),

              // 观看纪录/收藏影片
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyAttrView(
                      imgFileLeft: Images.icRecordClock,
                      iconMargin: EdgeInsets.only(left: Screen.scaleA(5)),
                      imgWidth: Screen.scaleA(18),
                      imgHeight: Screen.scaleA(18),
                      text: S.of(context).watchHistory,
                      textSize: Screen.scaleA(15),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10),
                    MyAttrView(
                      imgFileLeft: Images.icLike,
                      iconMargin: EdgeInsets.only(left: 5),
                      imgWidth: Screen.scaleA(18),
                      imgHeight: Screen.scaleA(18),
                      text: S.of(context).favoriteVideo,
                      textSize: Screen.scaleA(15),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]),

              Expanded(
                child: _buildListMenu(),
              )
            ],
          ),
        ),
        _buildSubItem()
      ],
    );
  }

  Widget _buildSubItem() {
    return StreamBuilder<int>(
      stream: bloc.selectedMenuIndex.stream,
      builder: (context, snapshot) {
        if (bloc.selectedMenuIndex.get() == null) return Container();
        MenuItem menuItem = bloc.menuItem[bloc.selectedMenuIndex.get()];
        List<MenuChildItem> childItems = menuItem.childItem;
        return childItems.isEmpty
            ? Container()
            : Container(
                color: Colors.black.withOpacity(0.8),
                alignment: Alignment.bottomCenter,
                width: Screen.scaleA(80),
                // 上方依數量留空
                padding: EdgeInsets.only(
                    top: Screen.height - 300 - 30 * bloc.menuItem.length > 0
                        ? Screen.scaleA(
                            Screen.height - 300 - 30 * bloc.menuItem.length)
                        : 0),
                child: ListView.builder(
                  itemCount: childItems.length,
                  itemBuilder: (context, index) {
                    return MyAttrView(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      text: childItems[index].title,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              );
      },
    );
  }

  /// 選單
  Widget _buildListMenu() {
    return StreamBuilder<int>(
      stream: bloc.selectedMenuIndex.stream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: bloc.menuItem.length,
          itemBuilder: (context, index) {
            MenuItem menuItem = bloc.menuItem[index];
            List childItems = menuItem.childItem;
            int selectedMenuIndex = snapshot.data;
            // 是否被選擇
            bool isSelectChild = index == selectedMenuIndex;

            return MyMaterialView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: isSelectChild ? DColors.selectMenuBg : null,
                ),
                alignment: Alignment.centerLeft,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text(menuItem.title,
                          style: TextStyle(
                              fontSize: Screen.scaleA(16),
                              fontWeight: FontWeight.w500,
                              color: isSelectChild
                                  ? Colors.white
                                  : Colors.black))),
                  childItems.isEmpty == false
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: isSelectChild ? Colors.white : Colors.black,
                          size: Screen.scaleA(15),
                        )
                      : Container(),
                  SizedBox(width: Screen.scaleA(20)),
                ]),
                padding: EdgeInsets.only(
                    bottom: Screen.scaleA(12),
                    top: Screen.scaleA(12),
                    left: Screen.scaleA(70),
                    right: 0),
              ),
              onPressed: () {
                bloc.selectedMenuIndex.set(index);
                if (childItems.isEmpty) {
                  _setSubPage(menuItem.routeName);
                }
              },
            );
          },
        );
      },
    );
  }

  void _setSubPage(String routeName) {
    Navigator.of(context).pop();
    ApplicationBloc.getInstance().setSubPage(routeName);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
