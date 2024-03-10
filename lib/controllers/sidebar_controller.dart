import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final CategoryController categoryController = Get.find<CategoryController>();
  final AuthController authController = Get.find<AuthController>();

  var my3curations = [].obs;
  var my3savedCurations = [].obs;
  var mycurations = [].obs;
  var mysavedCurations = [].obs;
  var myChipsofCurations = [].obs;
  var myChipsofSavedCurations = [].obs;
  final isPageLoading = false.obs;
  var savedCurationName = "".obs;

  @override
  void onInit() {
    super.onInit();
    my3Curations();
    my3SavedCurations();
  }

  setPageLoading(bool val) {
    isPageLoading.value = val;
  }

  my3Curations() async {
    setPageLoading(true);
    var response =
        await postRequestAuthenticated(endpoint: '/fetch/my/3/curations');
    if (response["success"]) {
      setPageLoading(false);
      my3curations.value = response['curations'];
      return "success";
    } else {
      setPageLoading(false);
      return "No curations";
    }
  }

  my3SavedCurations() async {
    setPageLoading(true);
    var response =
        await postRequestAuthenticated(endpoint: '/fetch/3/saved/curation');

    if (response["success"]) {
      setPageLoading(false);
      my3savedCurations.value = response['curations'];
      return "success";
    } else {
      setPageLoading(false);
      my3savedCurations.value = [];
      return "No Saved curations";
    }
  }

  myCurations() async {
    setPageLoading(true);
    var response =
        await postRequestAuthenticated(endpoint: '/fetch/all/my/curations');
    if (response["success"]) {
      setPageLoading(false);
      mycurations.value = response['curations'];
      return "success";
    } else {
      setPageLoading(false);
      return "No curations";
    }
  }

  mySavedCurations() async {
    setPageLoading(true);
    var response =
        await postRequestAuthenticated(endpoint: '/fetch/saved/curation');
    if (response["success"]) {
      setPageLoading(false);
      mysavedCurations.value = response['curations'];
      return "success";
    } else {
      setPageLoading(false);
      return "No Saved curations";
    }
  }

  fetchmyCurationChips() async {
    setPageLoading(true);
    var data = {
      "curation_id": categoryController.selectedCurationId.value,
      "user_id": authController.currentUser['_id']
    };
    // print(curationCaptionController.text);
    //jsonEncode(data)
    var response = await postRequestAuthenticated(
        endpoint: '/fetch/my/chips/of/curation', data: data);
    if (response["success"]) {
      setPageLoading(false);
      myChipsofCurations = response['chips'];
      return "success";
    } else {
      setPageLoading(false);
      return "failure";
    }
  }
  // fetchmySavedCurationChips() async {
  //   setPageLoading(true);
  //   var data = {
  //     "curation_id": categoryController.selectedCurationId.value,
  //     "user_id": authController.currentUser['_id']
  //   };
  //   // print(curationCaptionController.text);
  //   //jsonEncode(data)
  //   var response = await postRequestAuthenticated(
  //       endpoint: '/fetch/my/chips/of/curation', data: data);
  //   if (response["success"]) {
  //     setPageLoading(false);
  //     myChipsofCurations = response['chips'];
  //     return "success";
  //   } else {
  //     setPageLoading(false);
  //     return "failure";
  //   }
  // }
}
