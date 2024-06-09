import 'dart:convert';

class Attachment {
  final String fileName;
  final String fileType;
  final String fileUrl;

  Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
  });

  // Factory method to create an Attachment instance from JSON
  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileUrl: json['file_url'],
    );
  }

  // Method to convert an Attachment instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
    };
  }
}

class Comment {
  final String id;
  final String taskId;
  final String? projectId;
  final String content;
  final DateTime postedAt;
  final Attachment? attachment;

  Comment({
    required this.id,
    required this.taskId,
    this.projectId,
    required this.content,
    required this.postedAt,
    this.attachment,
  });

  // Factory method to create a Comment instance from JSON
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      taskId: json['task_id'],
      projectId: json['project_id'],
      content: json['content'],
      postedAt: DateTime.parse(json['posted_at']),
      attachment: json['attachment'] != null
          ? Attachment.fromJson(json['attachment'])
          : null,
    );
  }

  // Method to convert a Comment instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'project_id': projectId,
      'content': content,
      'posted_at': postedAt.toIso8601String(),
      'attachment': attachment?.toJson(),
    };
  }
}

// Function to parse a list of Comment objects from JSON
List<Comment> parseComments(String jsonResponse) {
  final List<dynamic> parsed = json.decode(jsonResponse);
  return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
}

// Function to convert a list of Comment objects to JSON
String commentsToJson(List<Comment> comments) {
  return json.encode(comments.map((comment) => comment.toJson()).toList());
}