import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyChipsCard extends StatelessWidget {
  EmptyChipsCard({super.key, required this.title});
  final String title;

  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.transparent,
        child: Column(
          children: [
            Image.asset(
              "assets/website/no_chips.png",
              width: 160,
              height: 140,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              textAlign: TextAlign.center,
              title == "chip"
                  ? "It looks like you’ve not added anything."
                  : "It looks like this category has no curations.",
              style: TextStyle(
                  color: Color(0xFFA3A3A3), letterSpacing: 1.2, fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                if (authController.isLoggedIn.value) {
                  if (title == "chip") {
                    ((homeController.selctedCategoryTab.value ==
                                        "From our Desk" ||
                                    homeController.selctedCategoryTab.value !=
                                        "Made by Chips") &&
                                authController.isLoggedIn.value &&
                                authController.currentUser['email'] ==
                                    'meenakshi@chips.social') ||
                            (homeController.selctedCategoryTab.value !=
                                    "From our Desk" &&
                                homeController.selctedCategoryTab.value !=
                                    "Made by Chips")
                        ? createChip(context)
                        : showErrorSnackBar(
                            heading: "Permission denied!",
                            message:
                                "You don't have authorization to perform this action.",
                            icon: Icons.warning,
                            color: Colors.white);
                  } else {
                    ((homeController.selctedCategoryTab.value ==
                                        "From our Desk" ||
                                    homeController.selctedCategoryTab.value ==
                                        "Made by Chips") &&
                                authController.isLoggedIn.value &&
                                authController.currentUser['email'] ==
                                    'meenakshi@chips.social') ||
                            (homeController.selctedCategoryTab.value !=
                                    "From our Desk" &&
                                homeController.selctedCategoryTab.value !=
                                    "Made by Chips")
                        ? newCurationModal(context)
                        : showErrorSnackBar(
                            heading: "Permission denied!",
                            message:
                                "You don't have authorization to perform this action.",
                            icon: Icons.warning,
                            color: Colors.white);
                  }
                } else {
                  showLoginDialog(context);
                }
              },
              child: Text(
                textAlign: TextAlign.center,
                title == "chip"
                    ? "Start curating with a chip ->"
                    : "Start a curation",
                style: TextStyle(color: ColorConst.primary, letterSpacing: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
