import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/pages/task_details_page.dart';
import 'package:task_management/services/functions/functions.dart';
import 'package:task_management/services/models/task_model.dart';
import 'package:task_management/services/providers/task_provider.dart';
import 'package:task_management/widgets/task_card_container.dart';

class CustomTaskBuilder extends StatelessWidget {
  final List<TaskModel> allTaskList;
  const CustomTaskBuilder({super.key, required this.allTaskList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 1.8,
      ),
      itemCount: allTaskList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var task = allTaskList[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsPage(
                taskModel: task,
              ),
            ),
          ),
          onLongPress: () {
            showSnackBar("Task deleted", context);
            Provider.of<TaskProvider>(context, listen: false)
                .deleteTask(task.id, task.notiId);
          },
          child: TaskCardContainer(task: task),
        );
      },
    );
  }
}
