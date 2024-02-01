import 'package:flutter/material.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with GetTickerProviderStateMixin {
  final HomeController homeController = Get.find<HomeController>();
  late TabController curationList;
  List<dynamic> filteredList = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  setTabController() {
    curationList = TabController(
        length: (homeController.curations.length + 1), vsync: this);

    setSelectedCurationIndex(0);
  }

  getChipList(List<dynamic> inputlist) {
    filteredList = inputlist.where((o) => o['curation'] == 'selectedCurationId').toList();
  }


  final selectedCurationIndex = 0.obs;
  final selectedCurationId = "null".obs;

  setSelectedCurationIndex(int index) {
    selectedCurationIndex.value = index;
  }

  setCurationId(String curationId) {
    selectedCurationId.value = curationId;
  }
}
