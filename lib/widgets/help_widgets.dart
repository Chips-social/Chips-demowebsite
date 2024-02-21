import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget PrimaryText(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: ColorConst.primary),
  );
}

Widget PrimaryBoldText(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: ColorConst.primary),
  );
}
