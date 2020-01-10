import 'package:app_updater/app_updater2.dart';
import 'package:flutter/material.dart';
import 'package:media_app/generated/i18n.dart';
import 'package:media_app/ui/widget/gradient_button.dart';
import 'package:media_app_core/business/model/version_check_model.dart';
import 'package:mx_core/mx_core.dart';


ProgressController _progressController;

/// 更新版本dialog
class UpdateVersionDialog extends Dialog {
  final VersionCheckModel data;

  UpdateVersionDialog(this.data) : super();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 0.8,
      heightFactor: 0.6,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Card(
          child: Material(
            color: Colors.transparent,
            child: Container(
              child: _BodyWidget(data),
            ),
          ),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final VersionCheckModel data;

  _BodyWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        Screen.scaleA(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              S.of(context).newVersion,
              style: TextStyle(
                color: Colors.black,
                fontSize: Screen.scaleSp(20),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: Screen.scaleA(100),
              right: Screen.scaleA(100),
              top: Screen.scaleA(10),
              bottom: Screen.scaleA(15),
            ),
            color: Colors.white,
            height: Screen.scaleA(2),
          ),
          _buildVersionNumber(context),
          _buildUpdateContent(context),
          Expanded(
            child: _buildUpdateMessage(context),
          ),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  /// 版本號
  Widget _buildVersionNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildText(S.of(context).versionNum),
        _buildText(data.latestVersionName),
      ],
    );
  }

  /// 更新內容標題
  Widget _buildUpdateContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Screen.scaleA(20),
      ),
      alignment: Alignment.center,
      child: Text(
        "",
        style: TextStyle(
          fontSize: Screen.scaleSp(20),
        ),
      ),
    );
  }

  /// 設置文字樣式
  Widget _buildText(String text) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Screen.scaleA(15),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: Screen.scaleSp(18),
        ),
      ),
    );
  }

  /// 版本更新內容
  Widget _buildUpdateMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Screen.scaleA(15),
      ),
      child: SingleChildScrollView(
        child: Text(
          "${data.updateMessage}",
          style: TextStyle(
            color: Colors.black,
            fontSize: Screen.scaleSp(18),
          ),
        ),
      ),
    );
  }

  /// 更新進度
  Widget _buildBottomWidget() {
    return StreamBuilder<DownloadData>(
        stream: AppUpdater2.downloadStream,
        initialData: DownloadData.progress(0),
        builder: (context, snapshot) {
          var downloadData = snapshot.data;
          var dataProgress = downloadData.progress.toDouble();
          print("dataProgress $dataProgress");
          if (!AppUpdater2.isDownloading) {
            _progressController?.setProgress(0);
          }
          return IndexedStack(
            index: AppUpdater2.isDownloading ? 0 : 1,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: Screen.width,
                height: Screen.scaleA(40),
                child: WaveProgress(
                  shape: BoxShape.rectangle,
                  style: WaveStyle(color: Colors.white, borderColor: Colors.green),
                  initProgress: 0,
                  progressStream: AppUpdater2.downloadStream.map((data) => data.progress.toDouble()),
                  onCreated: (controller) {
                    _progressController = controller;
                  },
                  builder: (context, progress, total) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${((progress / total) * 100).toInt()}%",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: Screen.width,
                child: GradientButton(
                  S.of(context).update,
                  onTap: () {
                    AppUpdater2.update(data.url, openWeb: data.redirectToWeb);
                  },
                ),
              ),
            ],
          );
        });
  }
}
