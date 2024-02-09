import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCurationController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  //final ChipController chipController = Get.put(ChipController());
  final CategoryController categoryController = Get.find<CategoryController>();
  final TextEditingController curationCaptionController =
      TextEditingController();
  final isPageLoading = false.obs;

  setPageLoading(bool val) {
    isPageLoading.value = val;
  }

   saveCuration() async{
    if(categoryController.selectedCurationId.value != "null"){
       var data = {
      "curation_id": categoryController.selectedCurationId.value
    };
     var response = await postRequestAuthenticated(
        endpoint: '/curation/saved/by', data: data );
    if (response["success"]) {
      print('saved successfully');
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
    } else{
      showErrorSnackBar(
          heading: 'Error',
          message: 'Please choose a curation and try again',
          icon: Icons.error,
          color: Colors.redAccent);
    }
    
  }

  addCuration() async {
    setPageLoading(true);
    var data = {
      "name": curationCaptionController.text,
      "category": homeController.selctedCategoryTab.value,
    };
    // print(curationCaptionController.text);
    var response =
        await postRequestAuthenticated(endpoint: '/add/curation', data: data);
    if (response["success"]) {
      setPageLoading(false);
      categoryController.selectedCurationId.value = response['curation']['_id'];
       homeController.allCurations();
      return categoryController.selectedCurationId;
    } else {
      setPageLoading(false);
      return null;
    }
  }
}
