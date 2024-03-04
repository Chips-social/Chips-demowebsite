import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
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
  final isLoading = false.obs;
  final visibility = "public".obs;
  final isAlreadyExist = false.obs;
  List exisitingCurators = [].obs;
  Rx<int> existingchips = 0.obs;

  var selectedValue = "".obs;

  @override
  void onInit() {
    selectedValue = homeController.selctedCategoryTab;
    super.onInit();
  }

  onChipTap(chip) async {
    selectedValue.value = chip;
  }

  setPageLoading(bool val) {
    isPageLoading.value = val;
  }

  saveCuration(context) async {
    if (categoryController.selectedCurationId.value != "null") {
      var data = {"curation_id": categoryController.selectedCurationId.value};
      var response = await postRequestAuthenticated(
          endpoint: '/curation/saved/by', data: data);
      if (response["success"]) {
        print('saved successfully');
        successChip(
            context,
            "You have successfully created a Chip in abc. You can find it in your Saved curations.",
            () {},
            "Go to saved curations");
      } else {
        showErrorSnackBar(
            heading: 'Error',
            message: response["message"],
            icon: Icons.error,
            color: Colors.redAccent);
      }
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: 'Please choose a curation and try again',
          icon: Icons.error,
          color: Colors.redAccent);
    }
  }

  createCuration() async {
    setPageLoading(true);
    var data = {
      "name": curationCaptionController.text,
      "category": selectedValue.value,
    };
    // print(curationCaptionController.text);
    //jsonEncode(data)
    var response =
        await postRequestAuthenticated(endpoint: '/add/curation', data: data);
    if (response["success"] && !response['create']) {
      setPageLoading(false);
      return "exist";
    } else if (response["success"]) {
      setPageLoading(false);
      categoryController.selectedCurationId.value = response['curation']['_id'];
      homeController.allCurations();
      return "success";
    } else {
      setPageLoading(false);
      return "failure";
    }
  }

  existingCurations() async {
    setPageLoading(true);
    var data = {
      "name": curationCaptionController.text,
    };
    var response = await postRequestAuthenticated(
        endpoint: '/existing/curations', data: data);
    if (response["success"]) {
      setPageLoading(false);
      exisitingCurators = response['curators'];
      exisitingCurators.insert(0, response['username']);
      existingchips.value = response['chip_length'];
      return response['data'];
    } else {
      setPageLoading(false);
      return showErrorSnackBar(
          heading: 'Error',
          message: 'Error whil making a collabration',
          icon: Icons.error,
          color: Colors.redAccent);
    }
  }
}
