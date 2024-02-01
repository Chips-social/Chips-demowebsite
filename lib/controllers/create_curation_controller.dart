
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

  setPageLoading (bool val) {
    isPageLoading.value = val;
  }

  addCuration() async {
     setPageLoading(true);
    var data = {
      "name": curationCaptionController.text,
      "category": homeController.selctedCategoryTab.value,
    };
    print(curationCaptionController.text);
    var response =
        await postRequestAuthenticated(endpoint: '/add/curation', data: data);
    if (response["success"]) {
       setPageLoading(false);
      categoryController.selectedCurationId.value = response['curation']['_id'];
      showErrorSnackBar(
          heading: 'Success',
          message: response["message"],
          icon: Icons.check_circle,
          color: ColorConst.success);
       return categoryController.selectedCurationId;
    } else {
       setPageLoading(false);
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
          return null;
    }
  }
}
