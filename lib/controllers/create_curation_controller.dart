import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

class CreateCurationController extends GetxController {
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController curationCaptionController = TextEditingController();
  final newCurationCheck = true.obs;

  addCuration ()async {
    var data = {
      "name": curationCaptionController.text,
      "category":homeController.selctedCategoryTab.value,
    };
    var response = await postRequestAuthenticated(
        endpoint: '/add/curation', data: jsonEncode(data));
    if (response["success"]) {
      if (response["success"]) {
      String? curationId = response["_id"];
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
      return curationId;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      return null;
    }
  }
}

}