import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController curationListController;

  final TextEditingController globalSearchController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  late List<GlobalKey<NavigatorState>> navigatorKeys = [];
  final RxList<int> _navigationStack = RxList<int>();
  final CategoryController categoryController = Get.put(CategoryController());

  var ownerName = "".obs;

  // late AnimationController animationController;
  // late Animation<Offset> animation;

  final categories = [
    'Food & Drinks',
    'Entertainment',
    'Science & Tech',
    'Art & Design',
    'Interiors & Lifestyle',
    'Travel',
    'Fashion & Beauty',
    'Health & Fitness',
    "Games & Sports"
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: categories.length, vsync: this);
    // setupAnimations();

    // allChips();
    allCurations();
  }

  setTabController() {
    curationListController =
        TabController(length: (curations.length + 1), vsync: this);

    categoryController.setSelectedCurationIndex(0);
  }

  void changeTab(int index, BuildContext context) {
    selctedCategoryTab.value = categories[index];
    allCurations();
    var categoryName = Uri.encodeComponent(selctedCategoryTab.value);
    Get.toNamed('/category/$categoryName');
    _navigationStack.add(index);
    update();
  }

  var chips = [].obs;
  var curations = [].obs;
  var chips_len = [].obs;

  var searchSuggestions = [].obs;

  final isLoading = false.obs;
  final isCurationListLoading = false.obs;
  final selctedCategoryTab = "Food & Drinks".obs;
  final isExplore = true.obs;
  final isSavedCuration = false.obs;
  final isMyCuration = false.obs;
  final drawerOpen = false.obs;

  fetchSearchSuggestions(String input) async {
    if (input.isEmpty) {
      searchSuggestions.value = [];
      return;
    }
    var data = {
      "name": input,
    };
    var response = await postRequestUnAuthenticated(
        endpoint: '/curation/search', data: data);
    if (response['success']) {
      searchSuggestions.value = response['curation'];
    } else {
      searchSuggestions.value = [];
    }
    update();
  }

  // bool back() {
  //   if (_navigationStack.length > 1) {
  //     _navigationStack.removeLast();
  //     selctedCategoryTab.value = categories[_navigationStack.last];
  //     update();
  //     return false;
  //   }
  //   return true;
  // }

  // void setupAnimations() {
  //   animationController = AnimationController(
  //     duration: const Duration(seconds: 2),
  //     vsync: this,
  //   );
  //   animation = Tween<Offset>(
  //     begin: Offset(0, -1), // Start off-screen (above)
  //     end: Offset.zero, // End at its final position
  //   ).animate(CurvedAnimation(
  //     parent: animationController,
  //     curve: Curves.linear,
  //   ));
  //   animationController.forward();
  // }

  allChips() async {
    isLoading.value = true;
    var data = {'curation_id': categoryController.selectedCurationId.value};

    var response = await postRequestUnAuthenticated(
        endpoint: '/fetch/all/chips/of/curation', data: data);
    if (response["success"]) {
      chips = List.from(response["chips"]).obs;
      update();
      isLoading.value = false;
    } else {
      // showErrorSnackBar(
      //     heading: 'Error',
      //     message: response["message"],
      //     icon: Icons.error,
      //     color: Colors.redAccent);
      chips = List.from([]).obs;
      isLoading.value = false;
    }
    update();
  }

  allCurations() async {
    isCurationListLoading.value = true;
    var data = {
      'category': selctedCategoryTab.value,
    };

    print(selctedCategoryTab.value);
    var response = await postRequestUnAuthenticated(
        endpoint: '/fetch/curations', data: data);
    if (response["success"]) {
      curations = List.from(response["curations"]).obs;
      isCurationListLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: 'Error',
          message: response["message"],
          icon: Icons.error,
          color: Colors.redAccent);
      curations = List.from([]).obs;
      isCurationListLoading.value = false;
    }
    update();
  }

  getUserName(String id) async {
    isLoading.value = true;
    var data = {
      "curation_id": id,
    };
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/username', data: data);
    if (response["success"]) {
      isLoading.value = false;
      ownerName.value = response['curation']['user_id']['name'];
      return "success";
    } else {
      isLoading.value = false;
      return "No Saved curations";
    }
  }
}
