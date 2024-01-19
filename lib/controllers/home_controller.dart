import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController curationList;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 7, vsync: this);
  }

  final categoryTabIndexMap = {
    0: 'Food & Drinks',
    1: 'Entertainment',
    2: 'Science & Tech',
    3: 'Art & Design',
    4: 'Interiors & Lifestyle',
    5: 'Travel',
    6: 'Fashion & Beauty',
  };

  final selctedCategoryTab = "Food & Drinks".obs;

  setCategoryTab(index) {
    selctedCategoryTab.value = '${categoryTabIndexMap[index]}';
  }
}
