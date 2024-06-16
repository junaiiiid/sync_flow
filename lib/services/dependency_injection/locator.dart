import 'package:flow_sync/services/language_service.dart';
import 'package:get_it/get_it.dart';
import '../local_storage_service.dart';
import '../network_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async{
  locator.registerLazySingleton<NetworkService>(() => NetworkService());
  locator.registerLazySingleton<LanguageService>(() => LanguageService());
  final localStorageService = LocalStorageService();
  await localStorageService.init();
  locator.registerSingleton<LocalStorageService>(localStorageService);
}
