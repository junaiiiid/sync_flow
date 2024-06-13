import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../board/model/section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  Project project = Project(
      id: "id",
      order: 0,
      color: "",
      name: "",
      commentCount: 0,
      isShared: false,
      isFavorite: false,
      isInboxProject: false,
      isTeamInbox: false,
      url: "",
      viewStyle: "");

  final TextEditingController projectNameController = TextEditingController();

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  set selectedColor(String? value) {
    _selectedColor = value;
    setState();
  }

  final List<String> colorNames = [
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

  Future<void> createNewProject() async {
    final dashboardProvider = StateService.context.read(ProviderService.dashboardProvider);
    final projectProvider = StateService.context.read(ProviderService.projectProvider);
    if (formKey.currentState?.validate() ?? false) {
      AppPopups.showLoader();
      project.color = selectedColor ?? "";
      project.name = projectNameController.text;
      project.viewStyle = ViewStyles.board.toShortString();
      await locator<NetworkService>().createNewProject(projectModel: project);
      projectProvider.callDispose();
      await dashboardProvider.refresh();
      StateService.pop();
      callDispose();
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
  }

  @override
  void callDispose() {
    project = Project(
        id: "id",
        order: 0,
        color: "",
        name: "",
        commentCount: 0,
        isShared: false,
        isFavorite: false,
        isInboxProject: false,
        isTeamInbox: false,
        url: "",
        viewStyle: "");
    projectNameController.clear();
    _selectedColor = null;
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
