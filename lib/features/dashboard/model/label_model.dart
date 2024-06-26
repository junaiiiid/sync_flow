import 'dart:convert';

class Label {
  final String id;
  final String name;
  final int order;
  final String color;
  bool isFavorite;

  Label({
    required this.id,
    required this.name,
    required this.order,
    required this.color,
    required this.isFavorite,
  });

  // Factory method to create a Task instance from JSON
  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      color: json['color'],
      isFavorite: json['is_favorite'],
    );
  }

  // Method to convert a Task instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'color': color,
      'is_favorite': isFavorite,
    };
  }
}

// Function to parse a list of Task objects from JSON
List<Label> parseLabels(List<dynamic>  jsonResponse) {
  List<Label> listOfLabels = [];
  for (var object in jsonResponse) {
    listOfLabels.add(Label.fromJson(object));
  }
  return listOfLabels;
}

// Function to convert a list of Task objects to JSON
String tasksToJson(List<Label> tasks) {
  return json.encode(tasks.map((task) => task.toJson()).toList());
}