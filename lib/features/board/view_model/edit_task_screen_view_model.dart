import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';

import '../../dashboard/model/task_model.dart';

class EditTaskScreenViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  List<TextEditingController> labelControllers = [];
  List<Section> get sectionsList => StateService.context.read(ProviderService.dashboardProvider).listOfSections;
  Label? selectedLabel;
  Section? selectedSection;

  Task? taskModel;

  void initialize({required Task model}){
    taskModel = model;
    taskTitleController.text = taskModel?.content ?? '';
    taskDescriptionController.text = taskModel?.description ?? '';
    dueDateController.text = taskModel?.due?.toFormattedDate() ?? '';
    for(String label in taskModel?.labels ?? []){
      final labelController = TextEditingController();
      labelController.text = label;
      labelControllers.add(labelController);
    }
    selectedSection = sectionsList.firstWhere((element)=>element.id==taskModel?.sectionId);
  }

  @override
  void callDispose() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    dueDateController.clear();
    selectedLabel = null;
    selectedSection = null;
    taskModel = null;
    labelControllers = [];
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
