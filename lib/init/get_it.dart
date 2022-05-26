import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingletonAsync(() => PackageInfo.fromPlatform());
}
