import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 33,
  height: 38,
  textStyle:
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: ColorConst.dark,
    borderRadius: BorderRadius.circular(5),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  color: ColorConst.dark,
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(),
);
