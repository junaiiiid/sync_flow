import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';

class CreateNewLabelViewModel extends BaseViewModel{
  final formKey = GlobalKey<FormState>();

  final TextEditingController labelNameController = TextEditingController();

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  set selectedColor(String? value) {
    _selectedColor = value;
    notifyListeners();
  }

  List<String> colorNames = [
    'berry_red',
    'red',
    'orange',
    'yellow',
    'olive_green',
    'lime_green',
    'green',
    'mint_green',
    'teal',
    'sky_blue',
    'light_blue',
    'blue',
    'grape',
    'violet',
    'lavender',
    'magenta',
    'salmon',
    'charcoal',
    'grey',
    'taupe',
  ];

  Future<void> createNewLabel() async{
    final dashBoardProvider = StateService.context.read(ProviderService.dashboardProvider);
    final labelsProvider = StateService.context.read(ProviderService.labelsProvider);
    AppPopups.showLoader();
     await locator<NetworkService>().createALabel(requestBody: {
       "name": labelNameController.text,
       "color": selectedColor,
     });
     await dashBoardProvider.refresh();
    labelsProvider.listOfLabels = dashBoardProvider.listOfLabels;
     callDispose();
     StateService.pop();
  }

  @override
  void callDispose() {
    labelNameController.clear();
    selectedColor = null;
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }

}