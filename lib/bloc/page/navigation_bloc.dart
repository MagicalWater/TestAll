import 'package:media_app/router/route.dart';
import 'package:media_app_core/business/model/version_check_model.dart';
import 'package:media_app_core/repository/version_repository.dart';
import 'package:mx_core/mx_core.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc extends PageBloc {
  NavigationBloc(RouteOption option) : super(Pages.navigation, option);

  /// 版本檢查倉庫
  VersionRepository _versionRepository = VersionRepository();

  /// 檢查更新
  Observable<VersionCheckModel> checkUpdate() {
    return _versionRepository.checkUpdate();
  }
}
