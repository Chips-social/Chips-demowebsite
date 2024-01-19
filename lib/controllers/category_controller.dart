import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController curationList;

  @override
  void onInit() {
    curationList = TabController(length: 3, vsync: this);
    super.onInit();
  }

  final selectedCurationIndex = 0.obs;

  setSelectedCurationIndex(int index) {
    selectedCurationIndex.value = index;
  }
}
