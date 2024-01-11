import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(
    {required String heading,
    required String message,
    required IconData icon,
    required Color color}) {
  return Get.snackbar(heading, message,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      titleText: Text(heading,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            fontFamily: 'Inter',
          )),
      messageText: Text(message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          )),
      snackStyle: SnackStyle.FLOATING);
}
