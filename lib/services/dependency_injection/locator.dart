import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:get_it/get_it.dart';
import '../network_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NetworkService>(() => NetworkService());
  locator.registerLazySingleton<BoardViewModel>(() => BoardViewModel());
}
