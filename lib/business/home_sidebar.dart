import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';

import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSidebar extends StatelessWidget {
  HomeSidebar({super.key});
  final AuthController authController = Get.put(AuthController());

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: getW(context) < 600
              ? const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
              : EdgeInsets.zero,
          height: getW(context) > 600 ? getH(context) - 115 : getH(context),
          color: ColorConst.primaryBackground,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        homeController.isExplore.value = true;
                        homeController.isSavedCuration.value = false;
                        homeController.isMyCuration.value = false;

                        GoRouter.of(context).go('/');
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            color: homeController.isExplore.value
                                ? ColorConst.dark
                                : Colors.transparent),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: getW(context) * 0.03, top: 5),
                          child: const Text(
                            'Explore\n',
                            style: TextStyle(
                                color: ColorConst.textFieldColor,
                                letterSpacing: 1.2,
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  homeController.isExplore.value
                      ? Container()
                      : const Divider(
                          color: ColorConst.dividerLine,
                        ),
                  SizedBox(height: authController.isLoggedIn.value ? 0 : 10),

                  // authController.isLoggedIn.value
                  //     ? SizedBox(height: getH(context) * 0.015)
                  //     : SizedBox(height: getH(context) * 0.03),
                  Obx(() => !authController.isLoggedIn.value
                      ? Padding(
                          padding: EdgeInsets.only(left: getW(context) * 0.006),
                          child: HomeStartCard(context),
                        )
                      : Container()),
                  const SizedBox(height: 5),
                ],
              ),
            ],
          )),
    );
  }
}
