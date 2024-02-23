import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';

import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/details_page.dart';
import 'package:chips_demowebsite/pages/login_modal.dart';
import 'package:chips_demowebsite/pages/my_curation_chips.dart';
import 'package:chips_demowebsite/pages/my_curations.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/pages/saved_curation_chips.dart';
import 'package:chips_demowebsite/pages/sidebar.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/menu_items.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthController authController = Get.put(AuthController());
  // final HomeController homeController = Get.put(HomeController());
  final HomeController homeController = Get.find<HomeController>();
  final ChipController chipController = Get.put(ChipController());
  final parser = EmojiParser();

  @override
  void dispose() {
    homeController.dispose();
    homeController.dispose();
    homeController.animationController.dispose();
    super.dispose();
  }

  void scrollTabsRight() {
    homeController.scrollController.animateTo(
      homeController.scrollController.offset + 150, // Scroll by 150 pixels
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollTabsLeft() {
    homeController.scrollController.animateTo(
      homeController.scrollController.offset - 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: getW(context) * 0.025),
                Obx(
                  () => Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 78,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.navigate_before_rounded),
                                color: ColorConst.primary,
                                onPressed: scrollTabsLeft,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: homeController.scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: TabBar(
                                    controller: homeController.tabController,
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    padding: EdgeInsets.zero,
                                    unselectedLabelColor: Colors.grey,
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelColor: ColorConst.primary,
                                    indicatorPadding: EdgeInsets.zero,
                                    indicatorColor: ColorConst.primary,
                                    dividerHeight: 0.3,
                                    dividerColor: Colors.grey,
                                    onTap: (index) {
                                      homeController.changeTab(index);
                                    },
                                    tabs: Categories.map(
                                            (category) => Tab(text: category))
                                        .toList(),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                color: ColorConst.primary,
                                onPressed: scrollTabsRight,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Expanded(
                              flex: 1,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: homeController.tabController,
                                children: Categories.map((String category) {
                                  int tabIndex = Categories.indexOf(category);
                                  return WillPopScope(
                                    onWillPop: () async {
                                      final currentNavigator = homeController
                                          .getKeys()[tabIndex]
                                          .currentState;
                                      if (currentNavigator!.canPop()) {
                                        currentNavigator.pop();
                                        return false;
                                      }
                                      return true;
                                    },
                                    child: Navigator(
                                      key: homeController.getKeys()[tabIndex],
                                      onGenerateRoute:
                                          (RouteSettings settings) {
                                        return GetPageRoute(
                                            settings: settings,
                                            page: () => Obx(
                                                  () => homeController.isLoading
                                                              .value ||
                                                          homeController
                                                              .isCurationListLoading
                                                              .value
                                                      ? SizedBox(
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          child: const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        )
                                                      : TabWidget(
                                                          title: category,
                                                          chipsList:
                                                              homeController
                                                                  .chips,
                                                          curationsList:
                                                              homeController
                                                                  .curations,
                                                        ),
                                                ));
                                        //   case '/':
                                        //     builder = (BuildContext context) =>
                                      },
                                    ),
                                  );
                                }).toList(),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
