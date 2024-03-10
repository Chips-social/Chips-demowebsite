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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialCategory =
          Uri.decodeComponent(Get.parameters['categoryName'] ?? "");
      final initialIndex = homeController.categories.indexOf(initialCategory);
      if (initialIndex != -1) {
        homeController.selctedCategoryTab.value =
            homeController.categories[initialIndex];
        homeController.tabController.animateTo(
            initialIndex); // Consider using animateTo for a smoother transition
        homeController
            .allCurations(); // This now uses the updated selectedCategoryTab value
      }
    });
  }

  @override
  void dispose() {
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
    return WillPopScope(
      onWillPop: () async {
        return true;
        // return homeController.back();
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
              ],
            ),
          ]),
    );
  }
}
