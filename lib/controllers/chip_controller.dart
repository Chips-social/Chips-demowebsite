import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:textfield_tags/textfield_tags.dart';

class ChipController extends GetxController {
  ChipController() {
    tagController.addListener(_updateHasTags);
  }

  @override
  void onInit() {
    super.onInit();
    if (filteredNames.isEmpty) {
      filteredNames.value = Items;
    }
  }

  final showPreview = false.obs;
  final showUrl = false.obs;
  final isDateTime = false.obs;
  final selectedDate = DateTime.now().obs;
  final curationId = null.obs;
  final isLoading = false.obs;
  final formattedDate = ''.obs;
  final isCreatingChip = false.obs;

  final isSavedChip = false.obs;

  final counter = 0.obs;
  final location = "".obs;
  final locationUrl = "".obs;
  final showImagePreview = false.obs;
  final isLocation = false.obs;
  final selectedSavedCurationIndex = false.obs;
  RxList filteredNames = <String>[].obs;

  List imageUrls = [].obs;

  RxInt selectedCurationModalIndex = (-1).obs;
  final RxBool hasTags = false.obs;

  RxList<Uint8List> imageBytesList = <Uint8List>[].obs;
  List<File> files = [];
  final TextEditingController urlController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final TextEditingController locationController = TextEditingController();
  final CreateCurationController curationController =
      Get.put(CreateCurationController());
  RxList<Map<String, String>> suggestions = RxList<Map<String, String>>();

  final TextfieldTagsController tagController = TextfieldTagsController();

  void _updateHasTags() {
    hasTags.value = tagController.getTags!.isNotEmpty;
  }

  void filterNames(String query) {
    if (query.isEmpty) {
      filteredNames.value = List<String>.from(Items);
      print("emoty"); // Explicitly typed as List<String>
    } else {
      filteredNames.value = Items.where(
              (name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList()
          .cast<String>();
      update(); // Use cast<String>() to ensure the list contains strings
    }
  }

  @override
  void dispose() {
    super.dispose();
    tagController.dispose();
  }

  // setSelectedSavedCurationIndex(int index) {
  //   selectedSavedCurationIndex.value = index;
  // }

  void setCounter(int a) {
    counter.value = a;
    update();
  }

  void selectModalCard(int index) {
    if (selectedCurationModalIndex.value == index) {
      selectedCurationModalIndex.value = -1;
    } else {
      selectedCurationModalIndex.value = index;
    }
    update();
  }

  void toggleSave() {
    isSavedChip.value = !isSavedChip.value;
    update();
  }
  // setInitialization() {
  //   chipScrollController.addListener(() {});
  //   print('Scroll offset: ${chipScrollController.offset}');
  //   update();
  // }

  setPreview(bool value) {
    showPreview.value = value;
  }

  setDateTime(bool val) {
    isDateTime.value = val;
  }

  setDate(DateTime date) {
    selectedDate.value = date;
  }

  setLoading(bool val) {
    isLoading.value = val;
  }

  clearCaptionAndPreview() {
    captionController.clear();
    tagController.clearTags;
    location.value = "";
    urlController.clear();
    formattedDate.value = "";
    imageUrls = [].obs;
  }

  addChipToCuration(context) async {
    var data = {
      "name": authController.currentUser['name'],
      "text": captionController.text,
      "tags": tagController.getTags,
      "category": homeController.selctedCategoryTab.value,
      "curation": categoryController.selectedCurationId.value,
      "location_url": location.value,
      "url": urlController.text,
      "date": formattedDate.value,
      "images": imageUrls,
    };
    var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      homeController.allChips();
      clearCaptionAndPreview();
      successChip(
          context,
          "You have successfully created a Chip in ${categoryController.selectedCurationName.value}. You can find it in your Saved curations.",
          () {},
          "Go to");
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

  // createChip() async {
  //   setLoading(true);
  //   if (categoryController.selectedCurationId.value == "null") {
  //     var data = {
  //       "text": captionController.text,
  //       "category": homeController.selctedCategoryTab.value,
  //       "is_datetime": isDateTime.value,
  //       "date": selectedDate.toString(),
  //       "images": getFileUrls(files),
  //       "source_url": urlController.text,
  //       //"source_url": nestedUrlController.text,
  //       //"location_urls":locationController.text,
  //       //other fields
  //     };
  //     var response = await postRequestAuthenticated(
  //         endpoint: '/add/chip', data: jsonEncode(data));
  //     if (response["success"]) {
  //       setLoading(false);
  //       var chips = response['chip'];
  //       // print(chips);
  //       print("chip added to queue ");
  //       print(selectedDate.value);
  //       homeController.allChips();
  //       clearCaptionAndPreview();
  //       showErrorSnackBar(
  //           heading: 'Success',
  //           message: response["message"],
  //           icon: Icons.check_circle,
  //           color: ColorConst.success);
  //       // return chipId;
  //       return {"success": true, "message": "added Chip"};
  //     } else {
  //       setLoading(false);
  //       showErrorSnackBar(
  //           heading: 'Error',
  //           message: response["message"],
  //           icon: Icons.error,
  //           color: Colors.redAccent);
  //       return {"success": false, "message": response["message"]};
  //     }
  //   } else {
  //     var data = {
  //       "text": captionController.text,
  //       "category": homeController.selctedCategoryTab.value,
  //       "curation": categoryController.selectedCurationId.value,
  //       "is_datetime": isDateTime.value,
  //       "date": selectedDate.toString(),
  //       "images": getFileUrls(files),
  //       "source_url": urlController.text,
  //       //"source_url": nestedUrlController.text,
  //       //"location_urls":locationController.text,
  //       //other fields
  //     };
  //     print(urlController.text);
  //     var response = await postRequestAuthenticated(
  //         endpoint: '/add/chip', data: jsonEncode(data));
  //     if (response["success"]) {
  //       var chips = response['chip'];
  //       print(chips);
  //       homeController.allChips();
  //       clearCaptionAndPreview();
  //       //homeController.allCurations();
  //       setLoading(false);
  //       print("chip added to curation");
  //       var chipId = response["_id"];
  //       showErrorSnackBar(
  //           heading: 'Success',
  //           message: response["message"],
  //           icon: Icons.check_circle,
  //           color: ColorConst.success);
  //       // return chipId;
  //       return {"success": true, "message": "added Chip"};
  //     } else {
  //       setLoading(false);
  //       showErrorSnackBar(
  //           heading: 'Error',
  //           message: response["message"],
  //           icon: Icons.error,
  //           color: Colors.redAccent);
  //       return {"success": false, "message": response["message"]};
  //     }
  //   }
  // }

  removeImage(int index) {
    imageBytesList.removeAt(index);
  }
}
