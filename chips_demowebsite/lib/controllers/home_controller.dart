import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController curationList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 7, vsync: this);
    curationList = TabController(length: 3, vsync:this);// length must be the length of curation array of that category. 
  }
}
