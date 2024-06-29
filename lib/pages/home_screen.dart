import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/pages/add_new_task_page.dart';
import 'package:task_management/pages/login_page.dart';
import 'package:task_management/services/functions/auth_functions.dart';
import 'package:task_management/services/functions/notification_functions.dart';
import 'package:task_management/services/providers/task_provider.dart';
import 'package:task_management/widgets/custom_task_builder.dart';
import 'package:task_management/widgets/how_to_use_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.person_2, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Text(
                  "Hi, ${Provider.of<TaskProvider>(context).userName}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            const HowToUseButton(),
            IconButton(
              padding: const EdgeInsets.only(
                right: 10,
                left: 20,
              ),
              onPressed: () {
                AuthFunctions.logOut();
                NotificationFunctions.deleteAllNotification();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: value.allTaskList.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    Text("No tasks available"),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "All Tasks",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTaskBuilder(
                        allTaskList: value.allTaskList,
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 0, 255),
          foregroundColor: Colors.white,
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const AddNewTaskPage(),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      );
    });
  }
}
