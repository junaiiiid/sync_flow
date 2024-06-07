import 'dart:async';

import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/numeric_constants.dart';
import 'package:flow_sync/services/state_service.dart';

class SplashViewModel extends BaseViewModel{

  late Timer splashTimer;

  @override
  void callDispose() {
    splashTimer.cancel();
  }

  @override
  void callInitState() {
    splashTimer = Timer.periodic(NumericConstants.splashDuration, (_){
      StateService.navigateAfterSplash();
    });
  }

}