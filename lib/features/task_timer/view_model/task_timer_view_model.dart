import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/local_storage_service.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';
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

  List<TimerTaskModel?> taskTimerHistory = [];

  @override
  void callDispose() {
    _selectedTask = null;
    _selectedProject = null;
    taskTimerHistory = [];
  }
  
  Future<void> startANewTask({required TimerTaskModel model}) async{
    List<String> listOfTaskIds = locator<LocalStorageService>().getTasksHistory() ?? [];
    if(listOfTaskIds.contains(model.task!.id)){
      AppPopups.showSnackBar(
          type: SnackBarTypes.error,
          content: LanguageService.getString.taskAlreadyExistsInHistory);
    }
    else{
     await _startTask(model: model);
    }
  }

  Future<void> _startTask({required TimerTaskModel model}) async{
    model.startTime = DateTime.now();
    model.isResumed = true;
    model.isPaused = false;
    model.isEnded = false;
    model.pauseTimes = [];
    model.resumeTimes = [];
    await locator<LocalStorageService>().modifyATaskTimer(model: model, messageToShow: LanguageService.getString.timerStartedSuccessfully);
    getTaskHistory();
  }

  Future<void> stopTask({required TimerTaskModel model}) async{
    model.endTime = DateTime.now();
    model.isResumed = false;
    model.isPaused = false;
    model.isEnded = true;
    await locator<LocalStorageService>().modifyATaskTimer(model: model, messageToShow: LanguageService.getString.timerStoppedSuccessfully);
    getTaskHistory();
  }

  Future<void> pauseTask({required TimerTaskModel model}) async{
    model.pauseTimes?.add(DateTime.now());
    model.isResumed = false;
    model.isPaused = true;
    model.isEnded = false;
    await locator<LocalStorageService>().modifyATaskTimer(model: model, messageToShow: LanguageService.getString.timerPausedSuccessfully);
    getTaskHistory();
  }
  
  Future<void> resumeTask({required TimerTaskModel model}) async{
    model.resumeTimes?.add(DateTime.now());
    model.isResumed = false;
    model.isPaused = true;
    model.isEnded = false;
    await locator<LocalStorageService>().modifyATaskTimer(model: model, messageToShow: LanguageService.getString.timerResumedSuccessfully);
    getTaskHistory();
  }

  Future<void> restartTask({required TimerTaskModel model}) async{
    _startTask(model: model);
    getTaskHistory();
  }

  void getTaskHistory({bool notify = true}){
    taskTimerHistory = [];
    final localStorageService = locator<LocalStorageService>();
    List<String> taskIds = localStorageService.getTasksHistory() ?? [];
    for(String task in taskIds){
      taskTimerHistory.add(localStorageService.getTimerTaskModel(id: task));
    }
    if(notify){
      setState();
    }
  }

  @override
  void callInitState() {
  }
}
