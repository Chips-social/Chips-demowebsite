import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

class LikeController extends GetxController {
  final chipId = 'null'.obs;
  final isLiked = false.obs;

 final HomeController homeController = Get.find<HomeController>();

  setChipId(String val){
    chipId.value = val;
    return val;
  }
  void checkLikedStatus(List<dynamic> likes, String userId) {
    isLiked.value = likes.contains(userId);
  }

  likeUnlikeChip() async {
    var data = {
      "chip_id": chipId.value
    };
     var response = await postRequestAuthenticated(
        endpoint: '/like/unlike/chip', data: jsonEncode(data));
    if (response["success"]) {
      print('like/unlike successful');
      homeController.allChips();
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
    }else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
    }
  } 


}