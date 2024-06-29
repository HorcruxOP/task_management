import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/services/functions/notification_functions.dart';
import 'package:task_management/services/models/task_model.dart';
import 'package:task_management/services/providers/task_provider.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:task_management/widgets/save_close_button.dart';
import 'package:task_management/widgets/select_date_and_time.dart';

class TaskDetailsPage extends StatefulWidget {
  final TaskModel taskModel;
  const TaskDetailsPage({super.key, required this.taskModel});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController estimatedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? deadLine;
  String? formattedDeadLine;
  @override
  void initState() {
    titleController.text = widget.taskModel.title;
    descriptionController.text = widget.taskModel.description;
    estimatedController.text = widget.taskModel.estimatedTime;
    deadLine = DateTime.parse(widget.taskModel.deadLine);
    formattedDeadLine = DateFormat("dd-MM-yyyy HH:mm").format(deadLine!);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    estimatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "Update Task",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                CustomTextfield(
                  hintText: "Enter the title",
                  labelText: "Title*",
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can't be empty";
                    }
                    return null;
                  },
                ),
                CustomTextfield(
                  maxLines: null,
                  hintText: "Enter the task description",
                  labelText: "Description",
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                ),
                CustomTextfield(
                  hintText: "Enter the time in minutes",
                  labelText: "Estimated time*",
                  controller: estimatedController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Estimated time can't be empty";
                    }
                    return null;
                  },
                ),
                Text(
                  "Deadline: $formattedDeadLine",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                SelectDateAndTime(
              dateSelect: (selectDate) {
                setState(() {
                  deadLine = DateTime(
                    selectDate!.year,
                    selectDate.month,
                    selectDate.day,
                    deadLine!.hour,
                    deadLine!.minute,
                  );
                  formattedDeadLine =
                      DateFormat("dd-MM-yyyy HH:mm").format(deadLine!);
                });
              },
              timeSelect: (selectTime) {
                setState(() {
                  deadLine = DateTime(
                    deadLine!.year,
                    deadLine!.month,
                    deadLine!.day,
                    selectTime!.hour,
                    selectTime.minute,
                  );
                  formattedDeadLine =
                      DateFormat("dd-MM-yyyy HH:mm").format(deadLine!);
                });
              },
            ),
                SaveCloseButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TaskModel taskModel = TaskModel(
                        id: widget.taskModel.id,
                        title: titleController.text,
                        description: descriptionController.text.trim(),
                        deadLine: deadLine.toString(),
                        estimatedTime: estimatedController.text,
                        color: widget.taskModel.color,
                        notiId: widget.taskModel.notiId,
                      );

                      Provider.of<TaskProvider>(context, listen: false)
                          .addNewTask(taskModel);
                      if ((deadLine!.difference(DateTime.now())).inMinutes >=
                          10) {
                        NotificationFunctions.deleteNotification(
                            widget.taskModel.notiId);
                        NotificationFunctions.scheduleNotification(
                          widget.taskModel.notiId,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
