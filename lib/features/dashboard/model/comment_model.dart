import 'dart:convert';

class Attachment {
  String fileName;
  String fileType;
  String fileUrl;

  Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileUrl: json['file_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
    };
  }
}

class Comment {
  String id;
  String? taskId;
  String? projectId;
  String content;
  DateTime postedAt;
  Attachment? attachment;

  Comment({
    required this.id,
    this.taskId,
    required this.projectId,
    required this.content,
    required this.postedAt,
    this.attachment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      taskId: json['task_id'],
      projectId: json['project_id'],
      content: json['content'],
      postedAt: DateTime.parse(json['posted_at']),
      attachment: json['attachment'] != null ? Attachment.fromJson(json['attachment']) : null,
    );
  }

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
List<Comment> parseComments(List<dynamic> jsonResponse) {
  List<Comment> listOfComment = [];
  for (var object in jsonResponse) {
    listOfComment.add(Comment.fromJson(object));
  }
  return listOfComment;
}

// Function to convert a list of Comment objects to JSON
String commentsToJson(List<Comment> comments) {
  return json.encode(comments.map((comment) => comment.toJson()).toList());
}
