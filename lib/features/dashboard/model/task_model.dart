import 'dart:convert';

class Task {
  String? id;
  String? assignerId;
  String? assigneeId;
  String projectId;
  String sectionId;
  String? parentId;
  int? order;
  String content;
  String description;
  bool? isCompleted;
  List<String>? labels;
  int? priority;
  int? commentCount;
  String? creatorId;
  DateTime createdAt;
  dynamic due;
  String? url;
  String? duration;

  Task copyWith({
    String? id,
    String? assignerId,
    String? assigneeId,
    String? projectId,
    String? sectionId,
    String? parentId,
    int? order,
    String? content,
    String? description,
    bool? isCompleted,
    List<String>? labels,
    int? priority,
    int? commentCount,
    String? creatorId,
    DateTime? createdAt,
    dynamic due,
    String? url,
    String? duration,
  }) {
    return Task(
      id: id ?? this.id,
      assignerId: assignerId ?? this.assignerId,
      assigneeId: assigneeId ?? this.assigneeId,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      order: order ?? this.order,
      content: content ?? this.content,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      labels: labels ?? this.labels,
      priority: priority ?? this.priority,
      commentCount: commentCount ?? this.commentCount,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      due: due ?? this.due,
      url: url ?? this.url,
      duration: duration ?? this.duration,
    );
  }

  Task({
    this.id,
    this.assignerId,
    this.assigneeId,
    required this.projectId,
    required this.sectionId,
    this.parentId,
    this.order,
    required this.content,
    required this.description,
    this.isCompleted,
    this.labels,
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
      sectionId: json['section_id'] ?? '',
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
      due: (json['due']!=null)?json['due'] is String ? Due(date: json['due'], string: '', lang: '', isRecurring: false) : Due.fromJson(json['due']):"null",
      url: json['url'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['assigner_id'] = assignerId;
    data['assignee_id'] = assigneeId;
    data['project_id'] = projectId;
    data['section_id'] = sectionId;
    data['parent_id'] = parentId;
    data['order'] = order;
    data['content'] = content;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['labels'] = labels;
    data['priority'] = priority;
    data['comment_count'] = commentCount;
    data['creator_id'] = creatorId;
    data['created_at'] = createdAt.toIso8601String();
    if (due != null) {
      // Check if due is a Due object or a String
      if (due is Due) {
        data['due'] = due!.toJson();
      } else {
        data['due'] = due; // Assuming due is a String
      }
    }
    data['url'] = url;
    data['duration'] = duration;
    return data;
  }
}

class Due {
  String date;
  String string;
  String lang;
  bool isRecurring;
  DateTime? datetime;

  Due({
    required this.date,
    required this.string,
    required this.lang,
    required this.isRecurring,
    this.datetime,
  });

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      date: json['date'],
      string: json['string'],
      lang: json['lang'],
      isRecurring: json['is_recurring'],
      datetime: json['datetime'] != null ? DateTime.parse(json['datetime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['string'] = string;
    data['lang'] = lang;
    data['is_recurring'] = isRecurring;
    if (datetime != null) {
      data['datetime'] = datetime!.toIso8601String();
    }
    return data;
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
