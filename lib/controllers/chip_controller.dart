import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:textfield_tags/textfield_tags.dart';

class ChipController extends GetxController {
  TextEditingController searchSaveController = TextEditingController();

  final SidebarController sidebarController = Get.find<SidebarController>();
  ChipController() {
    tagController.addListener(_updateHasTags);
    //  if (selectedSavedCurationIndex.value == false) {
    //    allCurations.value = sidebarController.mycurations;
    //  } else if (selectedSavedCurationIndex.value == true) {
    //    allCurations.value = sidebarController.mysavedCurations;
    //  }
  }

  // @override
  // void onInit() {
  //   super.onInit();

  // }

  final showPreview = false.obs;
  final showUrl = false.obs;
  final isDateTime = false.obs;
  final selectedDate = DateTime.now().obs;
  final curationId = null.obs;
  final isLoading = false.obs;
  final formattedDate = ''.obs;
  final isCreatingChip = false.obs;

  var chipsofCuration = [].obs;

  var openCurationId = "".obs;

  final counter = 0.obs;
  final location = "".obs;
  final locationUrl = "".obs;
  final showImagePreview = false.obs;
  final isLocation = false.obs;
  final selectedSavedCurationIndex = false.obs;
  var filteredNamesC = [].obs;

  var selectedName = "".obs;
  var selectedId = "".obs;
  var selectedChipId = "".obs;
  var selectedCurationId = "".obs;
  var selectedCategory = "".obs;

  List imageUrls = [].obs;

  RxInt selectedCurationModalIndex = (-1).obs;
  final RxBool hasTags = false.obs;
  var isChipOwner = false.obs;
  var isChipSaved = false.obs;

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

  // void getCurationsList() {
  //   if (selectedSavedCurationIndex.value == false) {
  //     filteredNames.value = sidebarController.mycurations;
  //   } else {
  //     filteredNames.value = sidebarController.mysavedCurations;
  //   }
  // }

  // void changeFiltersList(RxList<dynamic> acurations) {
  //   filteredNamesC = acurations;
  //   allCurationsValues = acurations;
  // }

  void filterNames(String query) {
    query = query.trim();
    List allCurations = selectedSavedCurationIndex.value
        ? sidebarController.mysavedCurations
        : sidebarController.mycurations;
    print(allCurations);
    if (query.isEmpty) {
      filteredNamesC.assignAll(allCurations);
    } else {
      filteredNamesC.value = allCurations
          .where((curation) => curation['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    update();
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

  void selectModalCard(String name, String id, String category) {
    selectedName.value = name;
    selectedId.value = id;
    selectedCategory.value = category;
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
      "user": authController.currentUser['name'],
      "text": captionController.text,
      "tags": tagController.getTags,
      "category": homeController.selctedCategoryTab.value,
      "curation": categoryController.selectedCurationId.value,
      "location_desc": location.value,
      "link_url": urlController.text,
      "date": formattedDate.value,
      "image_urls": imageUrls,
      "location_url": locationUrl.value
    };
    var response = await postRequestAuthenticated(
        endpoint: '/add/chip', data: jsonEncode(data));
    if (response["success"]) {
      homeController.allChips();
      Navigator.of(context).pop();
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

  saveChipToCuration(context) async {
    var data = {
      "chip_id": selectedChipId.value,
      "curation_id": selectedId.value,
      "category": selectedCategory.value,
      'origin_id': selectedCurationId.value
    };
    print(data);
    print(authController.currentUser['_id']);

    var response =
        await postRequestAuthenticated(endpoint: '/save/chip', data: data);
    if (response["success"]) {
      homeController.allChips();
      Navigator.of(context).pop();

      successChip(
          context,
          "You have successfully saved a Chip in ${selectedName.value}. You can find it in your Saved curations.",
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

  fetchchipsoCuration(context) async {
    isLoading.value = true;
    var data = {"curation_id": openCurationId.value};
    var response = await postRequestAuthenticated(
        endpoint: '/fetch/all/chips/of/curation', data: data);
    print(response);
    if (response["success"]) {
      isLoading.value = false;
      chipsofCuration = List.from(response["chips"]).obs;
      update();
      return {"success": true, "message": "Chips of Curation"};
    } else {
      isLoading.value = false;
      // showErrorSnackBar(
      //     heading: 'Error',
      //     message: response["message"],
      //     icon: Icons.error,
      //     color: Colors.redAccent);
      chipsofCuration = List.from([]).obs;
      return {"success": false, "message": response["message"]};
    }
  }

  void clearData() {
    captionController.clear();
    // tagController.clearTags();
    imageBytesList.value = [];
    imageUrls = [];
    location.value = "";
    locationUrl.value = "";
    urlController.clear();
    formattedDate.value = "";
    counter.value = 0;
  }

  unsaveChip(String curId) async {
    var data = {
      "chip_id": selectedChipId.value,
      "origin_id": curId,
      "user_id": authController.currentUser['_id'],
    };
    print(data);
    var response =
        await postRequestAuthenticated(endpoint: '/unsave/chip', data: data);
    if (response["success"]) {
      await homeController.allChips();
      return {"success": true, "message": "Unsaved Chip"};
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false, "message": response["message"]};
    }
  }

  removeImage(int index) {
    imageBytesList.removeAt(index);
  }

  deleteChip() async {
    isLoading.value = true;
    var data = {
      "chip_id": selectedChipId.value,
    };
    var response =
        await postRequestAuthenticated(endpoint: '/delete/chip', data: data);
    if (response["success"]) {
      homeController.allChips();
      isLoading.value = false;
      // Get.offAllNamed(
      //     '/category/${Uri.encodeComponent(homeController.selctedCategoryTab.value)}');
      return "exist";
    } else {
      isLoading.value = false;
      return "failure";
    }
  }
}
