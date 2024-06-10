import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

import '../../dashboard/model/label_model.dart';

class LabelsViewModel extends BaseViewModel{

  List<Label> get listOfLabels => StateService.context.read(ProviderService.dashboardProvider).listOfLabels;

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }

}