import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class MyToast {
  static void showToast(BuildContext context, String massage,
      [int duration = 5, int gravity = 0]) {
    Toastification().show(
      context: context,
      title: massage,
      autoCloseDuration: Duration(seconds: duration),
      margin: EdgeInsets.only(top: 20),
    );
  }
}
