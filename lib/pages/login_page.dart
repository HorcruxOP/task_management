// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/pages/home_screen.dart';
import 'package:task_management/services/functions/database_functions.dart';
import 'package:task_management/services/functions/functions.dart';
import 'package:task_management/services/providers/task_provider.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:task_management/widgets/submit_button.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  void navigateToHomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome User",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 45),
              CustomTextfield(
                hintText: "Enter your email",
                labelText: "Email",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!(value.contains("@"))) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              if (!isLogin)
                CustomTextfield(
                  hintText: "Enter your full name",
                  labelText: "Full name",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full name cannot be empty";
                    }
                    return null;
                  },
                ),
              CustomTextfield(
                hintText: "Enter your password",
                labelText: "Password",
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password should be atleast 6 characters";
                  }
                  return null;
                },
              ),
              SubmitButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool? check = await submitButton(emailController.text,
                        passwordController.text, isLogin, context);
                    if (check != null) {
                      if (!check) {
                        var userId = const Uuid().v4();
                        Provider.of<TaskProvider>(context, listen: false)
                            .userName = nameController.text;
                        DatabaseFunctions.newUserData(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          userId,
                        );
                      }
                      navigateToHomeScreen();
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  !isLogin
                      ? "Already have an account?"
                      : "Don't have an account?",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
