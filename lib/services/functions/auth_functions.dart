// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/services/functions/functions.dart';

class AuthFunctions {
  static Future<bool> signIn(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString().split("] ").last, context);
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> createAccount(
      String email, String password, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString().split("] ").last, context);
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
