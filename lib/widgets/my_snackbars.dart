import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(
    {required String heading,
    required String message,
    required IconData icon,
    required Color color}) {
  return Get.snackbar(heading, message,
      margin: EdgeInsets.zero,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorConst.dark,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      titleText: Text(heading,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 14,
            fontFamily: 'Inter',
          )),
      messageText: Text(message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          )),
      snackStyle: SnackStyle.GROUNDED);
}
