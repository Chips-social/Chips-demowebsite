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
  var curationId;
  var chipId;
  List<Uint8List> imageBytesList = [];
  List <File> files = [];
  final TextEditingController captionController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final CreateCurationController curationController = Get.put(CreateCurationController());
 
  setPreview(bool value) {
    showPreview.value = value;
  }

   getFileUrls(files) {
    //add file upload function
  }
  
 addChipToCuration() async {
  if( categoryController.selectedCurationId != "null"){
     var data = {
      "text": captionController.text,
      "category":homeController.selctedCategoryTab.value,
      "curation":categoryController.selectedCurationId,
      "is_datetime": false,
      "images": getFileUrls(files),
    };
    var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
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
}
createChip() async{
    var data = {
      "text": captionController.text,
      "category":homeController.selctedCategoryTab.value,
      "is_datetime": false,
      "images": getFileUrls(files),
      //"source_url": nestedUrlController.text,
      //"location_urls":locationController.text,
      //other fields
    };
    var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      String? chipId = response["_id"];
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
          return chipId;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
          return null;
    }
  }

 addChipsAllTabCase(String curationId)async{
    String? chipId = await createChip();
    var data = {
      "chip_id": chipId,
      "curation_id":curationId
    };
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