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
      id: json['id'] ?? 'default_id',
      assignerId: json['assigner_id'],
      assigneeId: json['assignee_id'],
      projectId: json['project_id'] ?? 'default_project_id',
      sectionId: json['section_id'] ?? 'default_section_id',
      parentId: json['parent_id'],
      order: json['order'] ?? 0,
      content: json['content'] ?? 'default_content',
      description: json['description'] ?? 'default_description',
      isCompleted: json['is_completed'] ?? false,
      labels: json['labels'] != null ? List<String>.from(json['labels']) : [],
      priority: json['priority'] ?? 1,
      commentCount: json['comment_count'] ?? 0,
      creatorId: json['creator_id'] ?? 'default_creator_id',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      due: json['due'] != null ? DateTime.parse(json['due']) : null,
      url: json['url'] ?? 'default_url',
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
  return jsonResponse.map((object) => Task.fromJson(object)).toList();
}

// Function to convert a list of Task objects to JSON
String tasksToJson(List<Task> tasks) {
  return json.encode(tasks.map((task) => task.toJson()).toList());
}
