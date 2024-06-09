import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';

import '../network_service.dart';

class LocatorService{
  LocatorService._();

  static NetworkService networkServiceLocator = locator<NetworkService>();
  static BoardViewModel boardViewModel = locator<BoardViewModel>();
}