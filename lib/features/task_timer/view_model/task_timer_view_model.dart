import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/local_storage_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import '../../dashboard/model/project_model.dart';
import '../../dashboard/model/task_model.dart';

class TaskTimerViewModel extends BaseViewModel {
  List<Task> get listOfTasks =>
      StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Project> get listOfProjects => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  Project? _selectedProject;

  Project? get selectedProject => _selectedProject;

  set selectedProject(Project? value) {
    _selectedProject = value;
    setState();
  }

  Task? _selectedTask;

  Task? get selectedTask => _selectedTask;

  set selectedTask(Task? value) {
    _selectedTask = value;
    setState();
  }

  List<TimerTaskModel> taskTimerHistory = [];

  @override
  void callDispose() {
    _selectedTask = null;
    _selectedProject = null;
  }

  Future<void> startTimer() async{
    TimerTaskModel timerTaskModel = TimerTaskModel(hasEnded: false,startTime: DateTime.now(),task: selectedTask);
    locator<LocalStorageService>().startStopATaskTimer(model: timerTaskModel);
  }

  Future<void> stopTimer() async{
    TimerTaskModel timerTaskModel = TimerTaskModel(hasEnded: true,endTime: DateTime.now(),task: selectedTask);
    locator<LocalStorageService>().startStopATaskTimer(model: timerTaskModel);
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
