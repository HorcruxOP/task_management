import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/services/functions/functions.dart';
import 'package:task_management/services/models/task_model.dart';

class DatabaseFunctions {
  static void newUserData(
      String email, String password, String fullName, String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userName', fullName);

      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "email": email,
        "password": password,
        "fullName": fullName,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static void addNewTask(TaskModel taskModel) async {
    try {
      var userId = await getUserIdFromLocal();
      var taskMap = taskModel.toMap();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .doc(taskModel.id)
          .set(taskMap);
    } catch (e) {
      log("add new task ${e.toString()}");
    }
  }

  static void isCompleteTask(TaskModel taskModel) async {
    try {
      var userId = await getUserIdFromLocal();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .doc(taskModel.id)
          .update({
        "isComplete": !taskModel.isComplete,
      });
    } catch (e) {
      log("add new task ${e.toString()}");
    }
  }

  static Future<String> fetchUserName() async {
    try {
      var userId = await getUserIdFromLocal();
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      return data["fullName"];
    } catch (e) {
      log(e.toString());
    }
    return "";
  }

  static Future<List<TaskModel>> fetchTaskList() async {
    try {
      var userId = await getUserIdFromLocal();

      var querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .get();

      List<Map<String, dynamic>> taskData =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      List<TaskModel> taskList = [];
      for (var task in taskData) {
        taskList.add(TaskModel.fromMap(task));
      }
      return taskList;
    } catch (e) {
      log('Error fetching tasks: $e');
    }
    return [];
  }

  static deleteTask(String taskId) async {
    try {
      var userId = await getUserIdFromLocal();
      var documentReference = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .doc(taskId);
      documentReference.delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
