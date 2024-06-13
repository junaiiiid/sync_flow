import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';

import '../../dashboard/model/project_model.dart';

class AddCommentViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  List<Project> get listOfProjects => StateService.context.read(ProviderService.dashboardProvider).listOfProjects;

  List<Task> get listOfTasks => StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
