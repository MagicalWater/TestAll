import 'package:media_app_core/env/env.dart';
import 'main.dart' as general;


void main() {
  initEnv(buildType: BuildType.debug);
  general.main();
}