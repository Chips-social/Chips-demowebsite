import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

class ChipController extends GetxController {
  final showPreview = false.obs;
  final showImagePreview = false.obs;
  final curationId = null.obs;
  var chipId;
  final isLoading = false.obs;
  List<Uint8List> imageBytesList = [];
  List<File> files = [];
  final TextEditingController captionController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final CreateCurationController curationController =
      Get.put(CreateCurationController());

  setPreview(bool value) {
    showPreview.value = value;
  }

  setLoading(bool val){
    isLoading.value = val;
  }
  getFileUrls(files) {
    //add file upload function
  }

  addChipToCuration() async {
      var data = {
        "text": captionController.text,
        "category": homeController.selctedCategoryTab.value,
        "curation": categoryController.selectedCurationId.value,
        "is_datetime": false,
        "images": getFileUrls(files),
      };
      var response = await postRequestAuthenticated(
          endpoint: '/add/chip', data: jsonEncode(data));
      if (response["success"]) {
        print("chip added to new curation");
        showErrorSnackBar(
            heading: 'Success',
            message: response["message"],
            icon: Icons.check_circle,
            color: ColorConst.success);
      } else {
        showErrorSnackBar(
            heading: 'Error',
            message: response["message"],
            icon: Icons.error,
            color: Colors.redAccent);
      }
  }

  createChip() async {
    setLoading(true);
    if(categoryController.selectedCurationId.value == "null"){
        var data = {
        "text": captionController.text,
        "category": homeController.selctedCategoryTab.value,
        "is_datetime": false,
        "images": getFileUrls(files),
        //"source_url": nestedUrlController.text,
        //"location_urls":locationController.text,
        //other fields
        };
        var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      setLoading(false);
      print("chip added to queue ");
      var chipId = response["_id"];
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
      // return chipId;
      return {"success": true, "message": "added Chip"};
    } else {
      setLoading(false);
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false, "message": response["message"]};
    }
    } else{  
        var data = {
          "text": captionController.text,
          "category": homeController.selctedCategoryTab.value,
          "curation":categoryController.selectedCurationId.value,
          "is_datetime": false,
          "images": getFileUrls(files),
          //"source_url": nestedUrlController.text,
          //"location_urls":locationController.text,
          //other fields
        };
        var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      print("chip added to curation");
      var chipId = response["_id"];
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
      // return chipId;
      return {"success": true, "message": "added Chip"};
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false, "message": response["message"]};
    }
    }
  }

  addChipsAllTabCase(String curationId) async {
    var chipId = await createChip();
    var data = {"chip_id": chipId, "curation_id": null};
    var response = await postRequestAuthenticated(
        endpoint: '/add/curation/to/chip', data: jsonEncode(data));
    if (response["success"]) {
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
    }
  }

  removeImage(int index) {
    showImagePreview.value = false;
    //files.removeAt(index);
    imageBytesList.removeAt(index);
    if (imageBytesList.isNotEmpty) {
      showImagePreview.value = true;
    }
  }
}
