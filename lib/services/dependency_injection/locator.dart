import 'package:get_it/get_it.dart';
import '../network_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NetworkService>(() => NetworkService());
}
