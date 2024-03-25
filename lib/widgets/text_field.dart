import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool obscureText;
  final String errorText;
  final Widget? suffixButton;
  final TextInputType? keyboard;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.obscureText,
      required this.errorText,
      this.suffixButton,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
          keyboardType: keyboard,
          obscureText: obscureText,
          controller: controller,
          style: const TextStyle(
              color: ColorConst.primaryText, fontFamily: 'Inter'),
          decoration: InputDecoration(
              floatingLabelStyle: errorText == 'null'
                  ? const TextStyle(
                      fontFamily: 'Inter', color: ColorConst.secondaryText)
                  : const TextStyle(
                      fontFamily: 'Inter', color: ColorConst.errorLight),
              filled: false,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              suffixIcon: suffixButton,
              // fillColor: ColorConst.primaryBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: ColorConst.primary, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: ColorConst.errorLight, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: ColorConst.errorLight, width: 1.0),
              ),
              hintText: hintText,
              // label: Text(
              //   hintText,
              //   style: const TextStyle(fontFamily: 'Inter'),
              // ),
              hintStyle: const TextStyle(
                  color: ColorConst.primaryGrey,
                  fontSize: 14,
                  fontFamily: 'Inter'),
              errorText: errorText == 'null' ? null : errorText,
              errorStyle: const TextStyle(
                  fontFamily: 'Inter', color: ColorConst.errorLight)),
          onChanged: onChanged),
    );
  }
}
