import 'package:flutter/material.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with GetTickerProviderStateMixin {
  final HomeController homeController = Get.find<HomeController>();
  late TabController curationListController;

  @override
  void onInit() {
    super.onInit();
  }

  setTabController() {
    curationListController = TabController(
        length: (homeController.curations.length + 1), vsync: this);

    setSelectedCurationIndex(0);
  }

  final selectedCurationIndex = 0.obs;
  final selectedCurationId = "null".obs;
  final selectedCurationName = "Queue".obs;

  setSelectedCurationName(String curationName) {
    selectedCurationName.value = curationName;
  }

  setSelectedCurationIndex(int index) {
    selectedCurationIndex.value = index;
  }

  setCurationId(String curationId) {
    selectedCurationId.value = curationId;
  }
}
