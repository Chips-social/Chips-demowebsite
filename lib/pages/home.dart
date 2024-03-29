import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';

import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/login_modal.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final ChipController chipController = Get.put(ChipController());
  final parser = EmojiParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.primaryBackground,
        body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height:5),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset('assets/icons/logo.png',
                              height: 100, width: 100),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 600,
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ColorConst.dark,
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(
                                      color: ColorConst.textFieldColor,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: ColorConst.textFieldColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                ))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Obx(() => authController.isLoggedIn.value
                              ? Initicon(
                                  text: authController.currentUser["name"],
                                  elevation: 4,
                                  backgroundColor: ColorConst.profileBackground,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: Colors.white, width: 2.0),
                                )
                              : PillButton(
                                  onTap: () async {
                                    _showLoginDialog(context);
                                  },
                                  text: 'Login or Sign up',
                                  textColor: ColorConst.buttonText,
                                  backGroundColor: ColorConst.primary,
                                  borderColor: ColorConst.primary,
                                  height: 40,
                                  width: 160,
                                )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                height:
                                    MediaQuery.of(context).size.height - 120,
                                //color: Colors.amber,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Home',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(
                                      color: ColorConst.dividerLine,
                                    ),
                                    const SizedBox(height: 40),
                                    Container(
                                      height: 220,
                                      width: 220,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: ColorConst.websiteHomeBox),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                                'assets/website/website_card.png',
                                                height: 50,
                                                width: 200),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 12),
                                                child: Column(
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                            'Welcome to Chips 👋',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        // parser.get('👋');
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                        'Save your favourites and Curate Your Internet.',
                                                        style: TextStyle(
                                                            color: ColorConst
                                                                .primary,
                                                            fontSize: 14)),
                                                    const SizedBox(height: 10),
                                                    PillButton(
                                                        onTap: () async {},
                                                        text: 'Start curating',
                                                        textColor: Colors.black,
                                                        width: 150,
                                                        height: 30,
                                                        backGroundColor:
                                                            ColorConst.primary)
                                                  ],
                                                ))
                                          ]),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Explore',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Trending',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Around you',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'view more',
                                          style: TextStyle(
                                              color: ColorConst.textFieldColor,
                                              fontSize: 12),
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: ColorConst.textFieldColor)
                                      ],
                                    ),
                                    const Divider(
                                      color: ColorConst.dividerLine,
                                    ),
                                    const Text(
                                      'Join Community',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Creators',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Chips.social',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 12),
                                    ),
                                    const Divider(
                                      color: ColorConst.dividerLine,
                                    ),
                                    const Text(
                                      'About',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Divider(
                                      color: ColorConst.dividerLine,
                                    ),
                                    const Text(
                                      'Say Hi!',
                                      style: TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ))),
                        const SizedBox(width: 24),
                        Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // #Home
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: TabBar(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              controller:
                                                  homeController.tabController,
                                              isScrollable: false,
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              labelColor: ColorConst.primary,
                                              indicatorColor:
                                                  ColorConst.primary,
                                              onTap: (index) async {
                                                homeController
                                                    .setCategoryTab(index);
                                                homeController.allChips();
                                                homeController.allCurations();
                                              },
                                              tabs: const [
                                                Tab(text: 'Food & Drinks'),
                                                Tab(text: 'Entertainment'),
                                                Tab(text: 'Science & Tech'),
                                                Tab(text: 'Art & Design'),
                                                Tab(
                                                    text:
                                                        'Interiors & Lifestyle'),
                                                Tab(text: 'Travel'),
                                                Tab(text: 'Fashion & Beauty'),
                                              ]),
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.navigate_next_rounded,
                                          color: ColorConst.primary,
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                      child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    controller: homeController.tabController,
                                    children: [
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Food & Drinks',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Entertainment',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Science & Tech',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Art & Design',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Interiors & Lifestyle',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Travel',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                      Obx(() => (homeController
                                                  .isLoading.value ||
                                              homeController
                                                  .isCurationListLoading.value)
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : TabWidget(
                                              title: 'Fashion & Beauty',
                                              chipsList: homeController.chips,
                                              curationsList:
                                                  homeController.curations,
                                            )),
                                    ],
                                  ))
                                ],
                              ),
                            )),
                      ],
                    ),
                  ]),
            )));
  }
}

void _showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Modal();
    },
  );
}

void createChip(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateChipModal();
    },
  );
}

void saveChipAs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SaveChipAsModal();
    },
  );
}



/* Widget getTabWidget({required String title}) {
  return Container(
    
    child: Text(
    title,
    style: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: ColorConst.primary),
  ));
} */
