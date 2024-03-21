import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:get/get.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key, required this.child});
  final Widget child;

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    homeController.scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getData();
      var initialCategory = Uri.decodeComponent(
          Get.parameters['categoryName'] ??
              Uri.encodeComponent("From our Desk"));
      if (authController.isLoggedIn.value) {
        initialCategory = Uri.decodeComponent(Get.parameters['categoryName'] ??
            Uri.encodeComponent("Made by Chips"));
      }
      final initialIndex = homeController.categories.indexOf(initialCategory);
      if (initialIndex != -1) {
        homeController.selctedCategoryTab.value =
            homeController.categories[initialIndex];
        homeController.tabController.animateTo(initialIndex);
        homeController.scrollController.animateTo(
            homeController.tabController.index * 150,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut);

        // homeController.scrollToSelectedTab();
        homeController.allCurations();
      }
    });
  }

  @override
  void dispose() {
    homeController.scrollController.dispose();
    super.dispose();
  }

  void scrollTabsRight() {
    homeController.scrollPart.value += 150;
    homeController.scrollController.animateTo(
      homeController.scrollController.offset + 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollTabsLeft() {
    homeController.scrollPart.value -= 150;
    homeController.scrollController.animateTo(
      homeController.scrollController.offset - 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (homeController.navigationStack.length >= 2) {
          homeController.navigationStack.removeLast();
          int last = homeController.navigationStack.last;
          homeController.selctedCategoryTab.value =
              homeController.categories[last];
          homeController.tabController.animateTo(last);
          homeController.allCurations();
          Get.back();
          return false;
        }
        return true;
      },
      child: Padding(
        padding: EdgeInsets.only(left: getW(context) * 0.024),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: getW(context) * 0.025),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 130,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getW(context) > 600
                              ? IconButton(
                                  icon: Icon(Icons.navigate_before_rounded),
                                  color: ColorConst.primary,
                                  onPressed: scrollTabsLeft,
                                )
                              : Container(),
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
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                                onTap: (index) {
                                  homeController.changeTab(index, context);
                                },
                                tabs: homeController.categories
                                    .map((category) => Tab(text: category))
                                    .toList(),
                              ),
                            ),
                          ),
                          getW(context) > 600
                              ? IconButton(
                                  icon: Icon(Icons.navigate_next_rounded),
                                  color: ColorConst.primary,
                                  onPressed: scrollTabsRight,
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(flex: 1, child: widget.child)
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
