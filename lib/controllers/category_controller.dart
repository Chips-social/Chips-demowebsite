import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with GetTickerProviderStateMixin {
  var categories = [
    'Food & Drinks',
    'Entertainment',
    'Science & Tech',
    'Art & Design',
    'Interiors & Lifestyle',
    'Travel',
    'Fashion & Beauty',
    'Health & Fitness'
  ].obs;

  final selectedCurationIndex = 0.obs;
  final selectedCurationId = "".obs;
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
