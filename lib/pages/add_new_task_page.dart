// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/widgets/alert_dialog_button.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:task_management/widgets/select_date_and_time.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController estimatedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? deadLine;
  String? formattedDeadLine;
  @override
  void initState() {
    deadLine = DateTime.now();
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
    return Form(
      key: _formKey,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Add new task"),
        actions: [
          AlertDialogOkButton(
            formKey: _formKey,
            titleController: titleController,
            descriptionController: descriptionController,
            estimatedController: estimatedController,
            deadLine: deadLine,
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
              maxLines: 3,
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
            )
          ],
        ),
      ),
    );
  }
}
