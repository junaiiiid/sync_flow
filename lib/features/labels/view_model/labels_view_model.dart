
import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

import '../../../services/dependency_injection/locator.dart';
import '../../dashboard/model/label_model.dart';

class LabelsViewModel extends BaseViewModel{

  List<Label> _listOfLabels = [Label(id: "id", name: "name", order: 0, color: "color", isFavorite: false)];

  List<Label> get listOfLabels => _listOfLabels;

  set listOfLabels(List<Label> value) {
    _listOfLabels = value;
    setState();
  }

  @override
  void callDispose() {
    _listOfLabels = [Label(id: "id", name: "name", order: 0, color: "color", isFavorite: false)];
  }

  @override
  void callInitState() {
    _listOfLabels.clear();
    _listOfLabels = StateService.context.read(ProviderService.dashboardProvider).listOfLabels;
  }

  Future<void> toggleFavouriteUnFavouriteLabel({required String labelId,required bool isFavourite}) async{
    final dashBoardProvider = StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().updateALabelById(labelId: labelId, requestBody: {
      "is_favorite":(!isFavourite)?true:"false",
    });
    final Label selectedLabel = dashBoardProvider.listOfLabels.firstWhere((element)=>element.id==labelId);
    selectedLabel.isFavorite = !isFavourite;
    dashBoardProvider.listOfLabels[dashBoardProvider.listOfLabels.indexOf(dashBoardProvider.listOfLabels.firstWhere((element)=>element.id==labelId))] = selectedLabel;
    setState();
    StateService.pop();
  }

  Future<void> deleteALabel({required String labelId}) async{
    final dashBoardProvider = StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().deleteLabelById(labelId: labelId);
    listOfLabels.removeWhere((element)=>element.id==labelId);
    dashBoardProvider.refresh();
    setState();
    StateService.pop();
  }

}