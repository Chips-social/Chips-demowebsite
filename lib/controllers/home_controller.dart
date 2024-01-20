import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'dart:convert';
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

  var chips = [];
  var curations = [];

  final selctedCategoryTab = "Food & Drinks".obs;

  setCategoryTab(index) {
    selctedCategoryTab.value = '${categoryTabIndexMap[index]}';
    print(selctedCategoryTab.value);
    return selctedCategoryTab.value;
  }
 
  allChips() async {
    var data = {
      'category':selctedCategoryTab.value,
    };
    var response = await getRequestAuthenticated(
        endpoint: '/fetch/chips', data: jsonEncode(data));
    if (response["success"]) {
      chips = List.from(response["chips"]);
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
    }
    else{
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
    }
}

 allCurations() async{
  var data = {
      'category':selctedCategoryTab.value,
    };
    var response = await getRequestUnAuthenticated(
        endpoint: '/fetch/curations', data: jsonEncode(data));
    if (response["success"]) {
      curations = List.from(response["curations"]);
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
    }
    else{
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
    }
 }
}
