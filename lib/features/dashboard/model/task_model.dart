import 'dart:convert';

class Task {
  String? id;
  String? assignerId;
  String? assigneeId;
  String projectId;
  String? sectionId;
  String? parentId;
  int? order;
  String content;
  String description;
  bool? isCompleted;
  List<String> labels;
  int? priority;
  int? commentCount;
  String? creatorId;
  DateTime createdAt;
  String? due;
  String? url;
  String? duration;

  Task({
    this.id,
    this.assignerId,
    this.assigneeId,
    required this.projectId,
    this.sectionId,
    this.parentId,
    this.order,
    required this.content,
    required this.description,
    this.isCompleted,
    required this.labels,
    this.priority,
    this.commentCount,
    this.creatorId,
    required this.createdAt,
    this.due,
    this.url,
    this.duration,
  });

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
      due: json['due'],
      url: json['url'],
      duration: json['duration'],
    );
  }

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
      'due': due,
      'url': url,
      'duration': duration,
    };
  }
}

// Function to parse a list of Task objects from JSON
List<Task> parseTasks(List<dynamic> jsonResponse) {
  return jsonResponse.map((object) => Task.fromJson(object)).toList();
}

// Function to convert a list of Task objects to JSON
String tasksToJson(List<Task> tasks) {
  return json.encode(tasks.map((task) => task.toJson()).toList());
}
