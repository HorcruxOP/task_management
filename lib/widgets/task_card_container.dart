import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/services/functions/functions.dart';
import 'package:task_management/services/models/task_model.dart';
import 'package:task_management/services/providers/task_provider.dart';

class TaskCardContainer extends StatelessWidget {
  final TaskModel task;
  const TaskCardContainer({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          curve: Curves.bounceIn,
          width: double.infinity,
          duration: const Duration(milliseconds: 300),
          height: double.infinity,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 40,
          ),
          decoration: BoxDecoration(
            color: task.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 25,
                  decoration:
                      task.isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
              if (task.description.isNotEmpty)
                Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    decoration:
                        task.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
              Text(
                "Deadline : ${formatDeadline(DateTime.parse(task.deadLine))}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  decoration:
                      task.isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
              Text(
                "Estimated time : ${task.estimatedTime} min",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  decoration:
                      task.isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            enableFeedback: !task.isComplete,
            padding: EdgeInsets.zero,
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .completeTask(task);
            },
            icon: Icon(
              task.isComplete ? Icons.check_circle : Icons.circle_outlined,
            ),
            color: task.isComplete ? Colors.green.shade700 : Colors.black,
          ),
        ),
      ],
    );
  }
}
