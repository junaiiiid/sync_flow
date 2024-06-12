import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../board/model/section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  late Project project;
  late List<Section> sections;

  final TextEditingController projectNameController = TextEditingController();

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

  Future<void> createNewProject() async {
    if (formKey.currentState?.validate() ?? false) {
      project = Project(
          color: selectedColor ?? "",
          name: projectNameController.text,
          viewStyle: ViewStyles.board.toShortString());
      await locator<NetworkService>().createNewProject(projectModel: project);
    } else {
      ScaffoldMessenger.of(StateService.context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.cherryRed,
            content: Text(
          'Fields Can Not Be Empty',
          style: AppTextStyles.labelLarge?.copyWith(color: AppColors.white),
        )),
      );
    }
  }

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
