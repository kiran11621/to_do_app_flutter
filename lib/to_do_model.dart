import 'package:uuid/uuid.dart';

class ToDoModel {
  String id;
  String description;
  Priority priority;
  bool isCompleted;
  String date;

  ToDoModel({
    String? id,
    required this.description,
    required this.priority,
    this.isCompleted = false,
    required this.date,
  }) : id = const Uuid().v4();
}

enum Priority {
  low,
  medium,
  high,
}
