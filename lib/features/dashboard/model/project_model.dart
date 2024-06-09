import 'dart:convert';

class Project {
  String id;
  String? parentId;
  int order;
  String color;
  String name;
  int commentCount;
  bool isShared;
  bool isFavorite;
  bool isInboxProject;
  bool isTeamInbox;
  String url;
  String viewStyle;

  Project({
    required this.id,
    this.parentId,
    required this.order,
    required this.color,
    required this.name,
    required this.commentCount,
    required this.isShared,
    required this.isFavorite,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.url,
    required this.viewStyle,
  });

  // Factory method to create a Project instance from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      parentId: json['parent_id'],
      order: json['order'],
      color: json['color'],
      name: json['name'],
      commentCount: json['comment_count'],
      isShared: json['is_shared'],
      isFavorite: json['is_favorite'],
      isInboxProject: json['is_inbox_project'],
      isTeamInbox: json['is_team_inbox'],
      url: json['url'],
      viewStyle: json['view_style'],
    );
  }

  // Method to convert a Project instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'order': order,
      'color': color,
      'name': name,
      'comment_count': commentCount,
      'is_shared': isShared,
      'is_favorite': isFavorite,
      'is_inbox_project': isInboxProject,
      'is_team_inbox': isTeamInbox,
      'url': url,
      'view_style': viewStyle,
    };
  }
}

// Function to parse a list of Project objects from JSON
List<Project> parseProjects(String jsonResponse) {
  final parsed = json.decode(jsonResponse).cast<Map<String, dynamic>>();
  return parsed.map<Project>((json) => Project.fromJson(json)).toList();
}

// Function to convert a list of Project objects to JSON
String projectsToJson(List<Project> projects) {
  return json.encode(projects.map((project) => project.toJson()).toList());
}
