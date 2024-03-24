import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EmptySavedCurations extends StatelessWidget {
  EmptySavedCurations({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        color: Colors.transparent,
        child: Column(
          children: [
            Image.asset(
              "website/no_chips.png",
              width: 150,
              height: 120,
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              textAlign: TextAlign.center,
              "It looks like you’ve not saved anything.",
              style: TextStyle(
                  color: Color(0xFFA3A3A3), letterSpacing: 1.4, fontSize: 12),
            ),
            const SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context).go('/');
              },
              child: const Text(
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
