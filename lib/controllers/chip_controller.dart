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
  final showUrl = false.obs;
  final isDateTime = false.obs;
  final selectedDate = DateTime.now().obs;
  final curationId = null.obs;
  final isLoading = false.obs;
  final formattedDate = ''.obs;
  final chipId = 'null'.obs;
  List<Uint8List> imageBytesList = [];
  List<File> files = [];
  final TextEditingController urlController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final CreateCurationController curationController =
      Get.put(CreateCurationController());

  setPreview(bool value) {
    showPreview.value = value;
  }
  setDateTime(bool val){
    isDateTime.value = val;
  }
  setDate(DateTime date) {
    selectedDate.value = date;
  }
  setLoading(bool val){
    isLoading.value = val;
  }
  setChipId(String val){
    chipId.value = val;
    return val;
  }
  getFileUrls(files) {
    //add file upload function
  }
  clearCaptionAndPreview() {
    captionController.clear();
    showPreview(false);
    showImagePreview(false);
  }

  addChipToCuration() async {
      var data = {
        "text": captionController.text,
        "category": homeController.selctedCategoryTab.value,
        "curation": categoryController.selectedCurationId.value,
        "source_url":urlController.text,
        "is_datetime": isDateTime.value,
        "date":selectedDate.toString(), 
        "images": getFileUrls(files),
      };
      var response = await postRequestAuthenticated(
          endpoint: '/add/chip', data: jsonEncode(data));
      if (response["success"]) {
        var chips = response['chip'];
        print(chips);
        print("chip added to new curation");
        homeController.allChips();
        clearCaptionAndPreview();
        showErrorSnackBar(
            heading: 'Success',
            message: response["message"],
            icon: Icons.check_circle,
            color: ColorConst.success);
            return {"success": true, "message": "added Chip to Curation"};
      } else {
        showErrorSnackBar(
            heading: 'Error',
            message: response["message"],
            icon: Icons.error,
            color: Colors.redAccent);
            return {"success": false, "message": response["message"]};
      }
  }

  createChip() async {
    setLoading(true);
    if(categoryController.selectedCurationId.value == "null"){
        var data = {
        "text": captionController.text,
        "category": homeController.selctedCategoryTab.value,
        "is_datetime": isDateTime.value,
        "date":selectedDate.toString(),  
        "images": getFileUrls(files),
        "source_url":urlController.text,
        //"source_url": nestedUrlController.text,
        //"location_urls":locationController.text,
        //other fields
        };
        var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      setLoading(false);
       var chips = response['chip'];
        print(chips);
      print("chip added to queue ");
      print(selectedDate.value);
      homeController.allChips();
      clearCaptionAndPreview();
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
          "is_datetime": isDateTime.value,
           "date":selectedDate.toString(), 
          "images": getFileUrls(files),
          "source_url":urlController.text,
          //"source_url": nestedUrlController.text,
          //"location_urls":locationController.text,
          //other fields
        };
        print(urlController.text);
        var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
       var chips = response['chip'];
        print(chips);
      homeController.allChips();
      clearCaptionAndPreview();
      //homeController.allCurations();
      setLoading(false);
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
      setLoading(false);
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false, "message": response["message"]};
    }
    }
  }

  likeUnlikeChip() async {
    var data = {
      "chip_id": chipId.value
    };
     var response = await postRequestAuthenticated(
        endpoint: '/like/unlike/chip', data: jsonEncode(data));
    if (response["success"]) {
      print('like/unlike successful');
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

  removeImage(int index) {
    showImagePreview.value = false;
    //files.removeAt(index);
    imageBytesList.removeAt(index);
    if (imageBytesList.isNotEmpty) {
      showImagePreview.value = true;
    }
  }
}
