import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptySavedCurations extends StatelessWidget {
  EmptySavedCurations({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.transparent,
        child: Column(
          children: [
            Image.asset(
              "website/no_chips.png",
              width: 150,
              height: 120,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              textAlign: TextAlign.center,
              "It looks like you’ve not saved anything.",
              style: TextStyle(
                  color: Color(0xFFA3A3A3), letterSpacing: 1.4, fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                Get.toNamed('/');
              },
              child: Text(
                textAlign: TextAlign.center,
                "Start Exploring ->",
                style: TextStyle(color: ColorConst.primary, letterSpacing: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
