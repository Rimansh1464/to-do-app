import 'dart:convert';

List<todoModel> animalFromJson(String str) =>
    List<todoModel>.from(json.decode(str).map((x) => todoModel.database(data: x)));
class todoModel {
  int? id;
  String? title;
  String? startTime;
  String? endTime;
  String? description;

  todoModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  factory todoModel.database({required Map data}) {
    return todoModel(
        id: data["id"],
        title: data["title"],
        startTime: data["startTime"],
        endTime: data["endTime"],
        description: data["description"]);
  }
}
