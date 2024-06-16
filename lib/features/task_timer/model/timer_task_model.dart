import 'dart:convert';

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

  TimerTaskModel(
      {this.isEnded,
      this.isPaused,
      this.isResumed,
      this.pauseTimes,
      this.resumeTimes,
      this.endTime,
      this.startTime,
      this.task});

  factory TimerTaskModel.fromJson(Map<String, dynamic> json) {
    return TimerTaskModel(
      isEnded: json['isEnded'] as bool?,
      isPaused: json['isPaused'] as bool?,
      isResumed: json['isResumed'] as bool?,
      pauseTimes: (json['pauseTimes'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      resumeTimes: (json['resumeTimes'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'] as String)
          : null,
      task: json['task'] != null
          ? Task.fromJson(json['task'] as Map<String, dynamic>)
          : null,
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

  Duration get elapsedTime {
    if (startTime == null) return Duration.zero;

    final endTime = this.endTime ?? DateTime.now();
    var totalElapsed = endTime.difference(startTime!);

    for (var i = 0; i < pauseTimes!.length; i++) {
      final pauseStart = pauseTimes![i];
      final pauseEnd = (i < resumeTimes!.length) ? resumeTimes![i] : endTime;
      totalElapsed -= pauseEnd.difference(pauseStart);
    }

    return totalElapsed;
  }
}
