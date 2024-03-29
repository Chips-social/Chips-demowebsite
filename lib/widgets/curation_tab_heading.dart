import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CurationTabHeading extends StatelessWidget {
  final String curationName;
  final bool isSelected;
  final String curationId;
  const CurationTabHeading(
      {super.key, required this.curationName, required this.isSelected, required this.curationId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: BoxDecoration(
          color: isSelected ? ColorConst.primary : ColorConst.chipBackground,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          curationName,
          style: TextStyle(
              color: isSelected ? ColorConst.buttonText : ColorConst.primary),
        ),
      ),
    );
  }
}
