import '../../dashboard/model/task_model.dart';

class TimerTaskModel {
  bool? isEnded;
  bool? isPaused;
  bool? isResumed;
  List<DateTime>? pauseTimes;
  List<DateTime>? resumeTimes;
  DateTime? endTime;
  DateTime? startTime;
  Task? task;

  TimerTaskModel(this.isEnded, this.isPaused, this.isResumed, this.pauseTimes,
      this.resumeTimes, this.endTime, this.startTime, this.task);

  factory TimerTaskModel.fromJson(Map<String, dynamic> json) {
    return TimerTaskModel(
      json['isEnded'] as bool?,
      json['isPaused'] as bool?,
      json['isResumed'] as bool?,
      (json['pauseTimes'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      (json['resumeTimes'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      json['startTime'] != null ? DateTime.parse(json['startTime'] as String) : null,
      json['task'] != null ? Task.fromJson(json['task'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnded': isEnded,
      'isPaused': isPaused,
      'isResumed': isResumed,
      'pauseTimes': pauseTimes?.map((e) => e.toIso8601String()).toList(),
      'resumeTimes': resumeTimes?.map((e) => e.toIso8601String()).toList(),
      'endTime': endTime?.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'task': task?.toJson(),
    };
  }
}
