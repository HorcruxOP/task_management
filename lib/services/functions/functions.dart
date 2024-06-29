import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/services/functions/auth_functions.dart';

Color randomColor() {
  Random random = Random();
  int red, green, blue;

  do {
    red = random.nextInt(256);
    green = random.nextInt(256);
    blue = random.nextInt(256);
  } while ((red == 255 && green == 255 && blue == 255) ||
      (red == 0 && green == 0 && blue == 0));

  return Color.fromARGB(70, red, green, blue);
}

String formatDeadline(DateTime? dateTime) {
  return DateFormat("dd-MM-yyyy HH:mm").format(dateTime!).toString();
}

Future<bool?> submitButton(
    String email, String password, bool isLogin, BuildContext context) async {
  if (isLogin) {
    bool signCheck = await AuthFunctions.signIn(email, password, context);
    if (signCheck) {
      return true;
    }
  } else if (!isLogin) {
    bool createCheck =
        await AuthFunctions.createAccount(email, password, context);
    if (createCheck) {
      return false;
    }
  }

  return null;
}

Future<String> getUserIdFromLocal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId')!;
}

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(text),
      backgroundColor: Colors.red,
    ),
  );
}

Future<int> generateIncrementNotiId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int currentId = prefs.getInt('notification_id') ?? 0;
  int newId = currentId + 1;
  await prefs.setInt('notification_id', newId);
  return newId;
}
