import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: homeController.tabController,
      children: homeController.categories.map((String category) {
        int tabIndex = homeController.categories.indexOf(category);
        return Obx(
          () => homeController.isLoading.value ||
                  homeController.isCurationListLoading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : TabWidget(),
        );
      }).toList(),
    );
  }
}
