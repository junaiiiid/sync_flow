import 'dart:convert';

class Section {
  final String id;
  final String projectId;
  final int order;
  final String name;

  Section({
    required this.id,
    required this.projectId,
    required this.order,
    required this.name,
  });

  // Factory method to create a Section instance from JSON
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      projectId: json['project_id'],
      order: json['order'],
      name: json['name'],
    );
  }

  // Method to convert a Section instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'order': order,
      'name': name,
    };
  }
}

// Function to parse a list of Section objects from JSON
List<Section> parseSections(List<dynamic> jsonResponse) {
  List<Section> listOfSections = [];
  for (var object in jsonResponse) {
    listOfSections.add(Section.fromJson(object));
  }
  return listOfSections;
}

// Function to convert a list of Section objects to JSON
String sectionsToJson(List<Section> sections) {
  return json.encode(sections.map((section) => section.toJson()).toList());
}