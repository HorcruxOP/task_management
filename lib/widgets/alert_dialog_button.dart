// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/services/functions/functions.dart';
import 'package:task_management/services/functions/notification_functions.dart';
import 'package:task_management/services/models/task_model.dart';
import 'package:task_management/services/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

class AlertDialogOkButton extends StatelessWidget {
  const AlertDialogOkButton({
    super.key,
    required this.formKey,
    this.deadLine,
    required this.titleController,
    required this.descriptionController,
    required this.estimatedController,
  });
  final GlobalKey<FormState> formKey;
  final DateTime? deadLine;
  final TextEditingController titleController,
      descriptionController,
      estimatedController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          var notiId = await generateIncrementNotiId();
          TaskModel taskModel = TaskModel(
            id: const Uuid().v4(),
            title: titleController.text,
            description: descriptionController.text,
            deadLine: deadLine.toString(),
            estimatedTime: estimatedController.text,
            color: randomColor(),
            notiId: notiId,
          );

          Provider.of<TaskProvider>(context, listen: false)
              .addNewTask(taskModel);

          if ((deadLine!.difference(DateTime.now())).inMinutes >= 10) {
            NotificationFunctions.scheduleNotification(
              notiId,
              deadLine!.subtract(
                const Duration(minutes: 10),
              ),
            );
          }
          titleController.clear();
          descriptionController.clear();
          estimatedController.clear();
          Navigator.pop(context);
        }
      },
      child: const Text("Ok"),
    );
  }
}
