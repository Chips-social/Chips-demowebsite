import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});
  final AuthController authController = Get.put(AuthController());
  final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
            padding: getW(context) < 600
                ? EdgeInsets.symmetric(horizontal: 15, vertical: 15)
                : EdgeInsets.zero,
            // height: getW(context) > 600 ? getH(context) - 100 : getH(context),
            color: ColorConst.primaryBackground,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAllNamed('/');
                    },
                    child: Container(
                      width: 200,
                      height: 38,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: getW(context) * 0.03),
                      decoration: BoxDecoration(color: ColorConst.dark),
                      child: const Text(
                        'Explore',
                        style: TextStyle(
                            color: ColorConst.textFieldColor,
                            letterSpacing: 1.2,
                            // decorationColor: ColorConst.primary,
                            // decorationThickness: 4.0,
                            // decoration: TextDecoration.underline,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                authController.isLoggedIn.value
                    ? SizedBox(height: getH(context) * 0.015)
                    : SizedBox(height: getH(context) * 0.03),
                !authController.isLoggedIn.value
                    ? Padding(
                        padding: EdgeInsets.only(left: getW(context) * 0.006),
                        child: HomeStartCard(context),
                      )
                    : Container(),
                const SizedBox(height: 5),
                Obx(
                  () => authController.isLoggedIn.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: getW(context) * 0.03),
                              child: bigText("Your Curations"),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              // height: 150,
                              padding:
                                  EdgeInsets.only(left: getW(context) * 0.03),
                              child: ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.toNamed('/curationchips/chipsa');
                                        Get.toNamed('/savedchips/chipsa');
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 9),
                                        child: smallText("Curations"),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getW(context) * 0.03, bottom: 5),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('/curation/abc');
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'view more',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 14),
                                    ),
                                    Icon(Icons.keyboard_arrow_right,
                                        size: 20,
                                        color: ColorConst.textFieldColor)
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              color: ColorConst.dividerLine,
                            ),
                          ],
                        )
                      : Container(),
                ),
                const SizedBox(height: 13),
                Padding(
                  padding: EdgeInsets.only(left: getW(context) * 0.03),
                  child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: _launchUrl,
                      child: bigText("Join Community")),
                ),
                Padding(
                  padding: EdgeInsets.only(left: getW(context) * 0.03),
                  child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: _launchUrl,
                      child: smallText("Creators")),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: getW(context) * 0.03),
                  child: smallText("Chips.Social"),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: ColorConst.dividerLine,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: getW(context) * 0.03),
                  child: bigText("About"),
                ),
                const Divider(
                  color: ColorConst.dividerLine,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: getW(context) * 0.03),
                  child: bigText("Say Hi"),
                ),
                const SizedBox(height: 15),
              ],
            )),
      ),
    );
  }
}
