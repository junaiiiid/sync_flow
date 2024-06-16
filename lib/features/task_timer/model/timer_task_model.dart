import '../../dashboard/model/task_model.dart';

class TimerTaskModel {
  bool? hasEnded;
  DateTime? endTime;
  DateTime? startTime;
  Task? task;

  TimerTaskModel({this.hasEnded, this.endTime, this.startTime, this.task});


  Map<String, dynamic> toJson() {
    return {
      'hasEnded': hasEnded,
      'endTime': endTime?.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'task': task?.toJson(),
    };
  }

  // Create instance from JSON
  factory TimerTaskModel.fromJson(Map<String, dynamic> json) {
    return TimerTaskModel(
      hasEnded: json['hasEnded'],
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      task: json['task'] != null ? Task.fromJson(json['task']) : null,
    );
  }
}
