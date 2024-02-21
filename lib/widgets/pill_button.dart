import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class PillButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final void Function()? onTap;
  final bool disabled;
  final double width;
  final double height;
  final Color backGroundColor;
  final Color borderColor;
  const PillButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.textColor,
      this.disabled = false,
      this.width = 150,
      this.height = 50,
      this.backGroundColor = ColorConst.secondaryText,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: disabled ? null : onTap,
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: ColorConst.primaryGrey,
              backgroundColor: backGroundColor,
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              side: BorderSide(color: borderColor, width: 1)),
          child: Text(
            getW(context) > 600 ? text : "Login",
            style: TextStyle(
                fontFamily: 'Inter',
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: getW(context) > 600 ? 14 : 12),
          )),
    );
  }
}
