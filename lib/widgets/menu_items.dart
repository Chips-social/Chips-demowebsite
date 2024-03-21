import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget bigText(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: ColorConst.textFieldColor,
        fontSize: 18,
        fontWeight: FontWeight.w700),
  );
}

Widget smallText(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: ColorConst.textFieldColor,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  );
}
