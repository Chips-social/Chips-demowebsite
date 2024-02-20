import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'dart:convert';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 7, vsync: this);
    allChips();
    allCurations();
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

  var chips = [];
  var curations = [];

  final isLoading = false.obs;
  final isCurationListLoading = false.obs;
  final selctedCategoryTab = "Food & Drinks".obs;

  setCategoryTab(index) {
    selctedCategoryTab.value = '${categoryTabIndexMap[index]}';
  }

  allChips() async {
    print("All Chips Called");
    isLoading.value = true;
    var data = {
      'category': selctedCategoryTab.value,
    };

    var response =
        await postRequestUnAuthenticated(endpoint: '/fetch/chips', data: data);
    if (response["success"]) {
      chips = List.from(response["chips"]);
      print(chips);
      isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      chips = List.from([]);
      isLoading.value = false;
    }
  }

  allCurations() async {
    isCurationListLoading.value = true;
    var data = {
      'category': selctedCategoryTab.value,
    };

    print(selctedCategoryTab.value);
    var response = await postRequestUnAuthenticated(
        endpoint: '/fetch/curations', data: data);
    if (response["success"]) {
      curations = List.from(response["curations"]);
      print(curations);
      isCurationListLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      curations = List.from([]);
      isCurationListLoading.value = false;
    }
  }
}
