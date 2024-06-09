import 'dart:convert';

class Task {
  final String id;
  final String? assignerId;
  final String? assigneeId;
  final String projectId;
  final String sectionId;
  final String? parentId;
  final int order;
  final String content;
  final String description;
  final bool isCompleted;
  final List<String> labels;
  final int priority;
  final int commentCount;
  final String creatorId;
  final DateTime createdAt;
  final DateTime? due;
  final String url;
  final int? duration;

  Task({
    required this.id,
    this.assignerId,
    this.assigneeId,
    required this.projectId,
    required this.sectionId,
    this.parentId,
    required this.order,
    required this.content,
    required this.description,
    required this.isCompleted,
    required this.labels,
    required this.priority,
    required this.commentCount,
    required this.creatorId,
    required this.createdAt,
    this.due,
    required this.url,
    this.duration,
  });

  // Factory method to create a Task instance from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      assignerId: json['assigner_id'],
      assigneeId: json['assignee_id'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'],
      order: json['order'],
      content: json['content'],
      description: json['description'],
      isCompleted: json['is_completed'],
      labels: List<String>.from(json['labels']),
      priority: json['priority'],
      commentCount: json['comment_count'],
      creatorId: json['creator_id'],
      createdAt: DateTime.parse(json['created_at']),
      due: json['due'] != null ? DateTime.parse(json['due']) : null,
      url: json['url'],
      duration: json['duration'],
    );
  }

  // Method to convert a Task instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assigner_id': assignerId,
      'assignee_id': assigneeId,
      'project_id': projectId,
      'section_id': sectionId,
      'parent_id': parentId,
      'order': order,
      'content': content,
      'description': description,
      'is_completed': isCompleted,
      'labels': labels,
      'priority': priority,
      'comment_count': commentCount,
      'creator_id': creatorId,
      'created_at': createdAt.toIso8601String(),
      'due': due?.toIso8601String(),
      'url': url,
      'duration': duration,
    };
  }
}

// Function to parse a list of Task objects from JSON
List<Task> parseTasks(List<dynamic> jsonResponse) {
  List<Task> listOfTasks = [];
  for (var object in jsonResponse) {
    listOfTasks.add(Task.fromJson(object));
  }
  return listOfTasks;
}

// Function to convert a list of Task objects to JSON
String tasksToJson(List<Task> tasks) {
  return json.encode(tasks.map((task) => task.toJson()).toList());
}
