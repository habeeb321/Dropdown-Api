import 'package:barcode_scanner/controller/home_provider.dart';
import 'package:barcode_scanner/services/all_data_service.dart';
import 'package:barcode_scanner/services/home_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<HomeProvider>(() => HomeProvider());
  locator.registerLazySingleton<HomeService>(() => HomeService());
  locator.registerLazySingleton<AllDataService>(() => AllDataService());
}
