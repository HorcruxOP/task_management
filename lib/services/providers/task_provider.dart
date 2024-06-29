import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/services/functions/database_functions.dart';
import 'package:task_management/services/functions/notification_functions.dart';
import 'package:task_management/services/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> allTaskList = [];
  late String userId;
  String userName = "Loading...";

  void initialise() async {
    await fetchUserId();
    await fetchTaskList();
  }

  void addNewTask(TaskModel taskModel) {
    bool taskExists = allTaskList.any((element) => element.id == taskModel.id);
    if (!taskExists) {
      allTaskList.add(taskModel);
    }
    DatabaseFunctions.addNewTask(taskModel);
    notifyListeners();
    fetchTaskList();
  }

  void deleteTask(String id, int notiId) {
    int index = allTaskList.indexWhere((element) => element.id == id);
    allTaskList.removeAt(index);
    notifyListeners();
    DatabaseFunctions.deleteTask(id);
    NotificationFunctions.deleteNotification(notiId);
  }

  void completeTask(TaskModel taskModel) {
    int index = allTaskList.indexWhere((element) => element.id == taskModel.id);
    allTaskList[index].isComplete = !allTaskList[index].isComplete;
    notifyListeners();
    DatabaseFunctions.isCompleteTask(taskModel);
  }

  Future fetchUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId")!;
    userName = preferences.getString("userName")!;
    notifyListeners();
  }

  Future fetchTaskList() async {
    allTaskList = await DatabaseFunctions.fetchTaskList();
    notifyListeners();
  }

  TaskModel fetchTaskData(String taskId) {
    var taskData = allTaskList.firstWhere((element) => element.id == taskId);
    return taskData;
  }
}
