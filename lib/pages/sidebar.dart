import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});
  final AuthController authController = Get.put(AuthController());
  final SidebarController sidebarController = Get.put(SidebarController());
  final CategoryController categoryController = Get.find<CategoryController>();

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
              ? EdgeInsets.symmetric(horizontal: 15, vertical: 15)
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
                        Get.offAllNamed(
                            '/category/${Uri.encodeComponent("Food & Drinks")}');
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
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: ColorConst.dividerLine,
                  ),

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
                  Obx(
                    () => authController.isLoggedIn.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 200,
                                  height: 38,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                      left: getW(context) * 0.03),
                                  decoration: BoxDecoration(
                                      color: homeController.isMyCuration.value
                                          ? ColorConst.dark
                                          : Colors.transparent),
                                  child: bigText("My Curations")),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: getW(context) * 0.03),
                                child: Obx(
                                  () => ListView.builder(
                                      itemCount:
                                          sidebarController.my3curations.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            homeController.isExplore.value =
                                                false;
                                            homeController
                                                .isSavedCuration.value = false;
                                            homeController.isMyCuration.value =
                                                true;
                                            chipController
                                                    .openCurationId.value =
                                                sidebarController
                                                    .my3curations[index]['_id'];

                                            await chipController
                                                .fetchchipsoCuration(context);
                                            var urltogo = Uri.encodeComponent(
                                                sidebarController
                                                    .my3curations[index]['name']
                                                    .toString());
                                            Get.toNamed(
                                                '/curationchips/$urltogo');
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 9),
                                            child: smallText(sidebarController
                                                .my3curations[index]['name']),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: 5),
                              sidebarController.my3curations.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: getW(context) * 0.03,
                                          bottom: 5),
                                      child: InkWell(
                                        onTap: () async {
                                          homeController.isExplore.value =
                                              false;
                                          homeController.isSavedCuration.value =
                                              false;
                                          homeController.isMyCuration.value =
                                              true;
                                          await sidebarController.myCurations();
                                          Get.toNamed(
                                              '/mycuration/MyCurations');
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'view more',
                                              style: TextStyle(
                                                  color:
                                                      ColorConst.textFieldColor,
                                                  fontSize: 14),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,
                                                size: 20,
                                                color:
                                                    ColorConst.textFieldColor)
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: getW(context) * 0.03),
                                      child: Text("No Curations!",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                              const Divider(
                                color: ColorConst.dividerLine,
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => authController.isLoggedIn.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 200,
                                  height: 38,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                      left: getW(context) * 0.03),
                                  decoration: BoxDecoration(
                                      color:
                                          homeController.isSavedCuration.value
                                              ? ColorConst.dark
                                              : Colors.transparent),
                                  child: bigText("Saved Curations")),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                // height: 150,
                                padding:
                                    EdgeInsets.only(left: getW(context) * 0.03),
                                child: Obx(
                                  () => ListView.builder(
                                      itemCount: sidebarController
                                          .my3savedCurations.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            homeController.isExplore.value =
                                                false;
                                            homeController
                                                .isSavedCuration.value = true;
                                            homeController.isMyCuration.value =
                                                false;
                                            chipController.openCurationId
                                                .value = sidebarController
                                                    .my3savedCurations[index]
                                                ['_id'];
                                            await chipController
                                                .fetchchipsoCuration(context);
                                            var urltogo = Uri.encodeComponent(
                                                sidebarController
                                                    .my3savedCurations[index]
                                                        ['name']
                                                    .toString());
                                            Get.toNamed('/savedchips/$urltogo');
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 9),
                                            child: smallText(sidebarController
                                                .my3savedCurations[index]
                                                    ['name']
                                                .toString()),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getW(context) * 0.03, bottom: 5),
                                child: sidebarController
                                        .my3savedCurations.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          homeController.isExplore.value =
                                              false;
                                          homeController.isSavedCuration.value =
                                              true;
                                          homeController.isMyCuration.value =
                                              false;
                                          await sidebarController
                                              .mySavedCurations();
                                          Get.toNamed('/savedcuration/abcd');
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'view more',
                                              style: TextStyle(
                                                  color:
                                                      ColorConst.textFieldColor,
                                                  fontSize: 14),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,
                                                size: 20,
                                                color:
                                                    ColorConst.textFieldColor)
                                          ],
                                        ),
                                      )
                                    : Container(
                                        child: Text("No Saved Curations!",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                              ),
                              const Divider(
                                color: ColorConst.dividerLine,
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: getW(context) * 0.03),
                    child: InkWell(
                        onTap: () {}, child: bigText("Join our servers")),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: getW(context) * 0.03),
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          _launchUrl("https://discord.gg/A9tSmuJ4yj");
                        },
                        child: smallText("Creators")),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: getW(context) * 0.03),
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          _launchUrl("https://discord.gg/zDKq4QSmQK");
                        },
                        child: smallText("Chips.Social")),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // const SizedBox(height: 5),
              // const Divider(
              //   color: ColorConst.dividerLine,
              // ),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: EdgeInsets.only(left: getW(context) * 0.03),
              //   child: bigText("About"),
              // ),
              // const Divider(
              //   color: ColorConst.dividerLine,
              // ),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: EdgeInsets.only(left: getW(context) * 0.03),
              //   child: bigText("Say Hi"),
              // ),
            ],
          )),
    );
  }
}
