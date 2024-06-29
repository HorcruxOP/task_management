import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String deadLine;
  final String estimatedTime;
  bool isComplete;
  final Color? color;
  final int notiId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadLine,
    required this.estimatedTime,
    this.isComplete = false,
    this.color,
    this.notiId = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "deadLine": deadLine,
      "estimatedTime": estimatedTime,
      "isComplete": isComplete,
      "color": color?.value,
      "notiId": notiId
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      deadLine: (map["deadLine"]),
      estimatedTime: (map["estimatedTime"]),
      isComplete: map["isComplete"],
      color: Color(map["color"]),
      notiId: map["notiId"],
    );
  }
}
