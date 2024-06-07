import 'package:flow_sync/features/home/view_model/home_view_model.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/splash/view_model/splash_view_model.dart';

class ProviderService {
  ProviderService._();

  static ChangeNotifierProvider<SplashViewModel> splashProvider =
  StateService.createProvider(() => SplashViewModel());

  static ChangeNotifierProvider<HomeViewModel> homeProvider =
  StateService.createProvider(() => HomeViewModel());
}
