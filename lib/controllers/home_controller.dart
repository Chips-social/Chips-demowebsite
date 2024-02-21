import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'dart:convert';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: Categories.length, vsync: this);
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<Offset>(
      begin: Offset(0, -1), // Start off-screen (above)
      end: Offset.zero, // End at its final position
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ));
    animationController.forward();
    allChips();
    allCurations();
  }

  var chips = [].obs;
  var curations = [];

  final isLoading = false.obs;
  final isCurationListLoading = false.obs;
  final selctedCategoryTab = "Food & Drinks".obs;
  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    Categories.length,
    (index) => GlobalKey<NavigatorState>(),
  ).obs;

  //  setCategoryTab(index) {
  //  selctedCategoryTab.value = '${categoryTabIndexMap[index]}';
  // }
  final RxInt tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
    update();
  }

  allChips() async {
    // print("All Chips Called");
    print('cscc');
    isLoading.value = true;
    var data = {
      'category': selctedCategoryTab.value,
    };

    var response =
        await postRequestUnAuthenticated(endpoint: '/fetch/chips', data: data);
    if (response["success"]) {
      chips = List.from(response["chips"]).obs;
      update();
      // print(chips);
      isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      chips = List.from([]).obs;
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
