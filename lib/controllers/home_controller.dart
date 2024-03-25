import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController curationListController;

  final TextEditingController globalSearchController = TextEditingController();

  late ScrollController scrollController;
  final RxList<int> navigationStack = RxList<int>();
  final CategoryController categoryController = Get.put(CategoryController());
  final AuthController authController = Get.find<AuthController>();

  var ownerName = "".obs;
  var scrollPart = 0.obs;
  var isSelectedTab = false.obs;

  // late AnimationController animationController;
  // late Animation<Offset> animation;

  void scrollToSelectedTab() {
    int calculatedOffset = tabController.index * 15;
    tabController.animateTo(
      calculatedOffset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  var categories = [
    'From our Desk',
    'Made by Chips',
    'Food & Drinks',
    'Entertainment',
    'Science & Tech',
    'Art & Design',
    'Interiors & Lifestyle',
    'Travel',
    'Fashion & Beauty',
    'Health & Fitness',
    "Games & Sports"
  ].obs;
  var interests = [
    'Food & Drinks',
    'Entertainment',
    'Science & Tech',
    'Art & Design',
    'Interiors & Lifestyle',
    'Travel',
    'Fashion & Beauty',
    'Health & Fitness',
    "Games & Sports"
  ].obs;
  var CurationImages = [
    "assets/website/curation_image.png",
    "assets/website/curation_image.png",
    "assets/website/food_drinks.png",
    "assets/website/entertainment.png",
    "assets/website/Science_tech.png",
    "assets/website/art__design.png",
    "assets/website/interior_lifestyle.png",
    "assets/website/travel.png",
    "assets/website/fashion_beauty.png",
    "assets/website/health_fitness.png",
    "assets/website/sports_games.png",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        length: categories.length,
        vsync: this,
        animationDuration: const Duration(microseconds: 1));
    getData();
    // setupAnimations();
    allCurations();
  }

  getData() {
    if (authController.isLoggedIn.value) {
      selctedCategoryTab.value = 'Food & Drinks';
      categories.value = [
        'Made by Chips',
        'Food & Drinks',
        'Entertainment',
        'Science & Tech',
        'Art & Design',
        'Interiors & Lifestyle',
        'Travel',
        'Fashion & Beauty',
        'Health & Fitness',
        "Games & Sports",
        'From our Desk',
      ];
      CurationImages.value = [
        "assets/website/curation_image.png",
        "assets/website/food_drinks.png",
        "assets/website/entertainment.png",
        "assets/website/Science_tech.png",
        "assets/website/art__design.png",
        "assets/website/interior_lifestyle.png",
        "assets/website/travel.png",
        "assets/website/fashion_beauty.png",
        "assets/website/health_fitness.png",
        "assets/website/sports_games.png",
        "assets/website/curation_image.png",
      ];
    } else {
      selctedCategoryTab.value = 'From our Desk';
      categories.value = [
        'From our Desk',
        'Made by Chips',
        'Food & Drinks',
        'Entertainment',
        'Science & Tech',
        'Art & Design',
        'Interiors & Lifestyle',
        'Travel',
        'Fashion & Beauty',
        'Health & Fitness',
        "Games & Sports",
      ];
      CurationImages.value = [
        "assets/website/curation_image.png",
        "assets/website/curation_image.png",
        "assets/website/food_drinks.png",
        "assets/website/entertainment.png",
        "assets/website/Science_tech.png",
        "assets/website/art__design.png",
        "assets/website/interior_lifestyle.png",
        "assets/website/travel.png",
        "assets/website/fashion_beauty.png",
        "assets/website/health_fitness.png",
        "assets/website/sports_games.png",
      ];
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  setTabController() {
    curationListController =
        TabController(length: (curations.length + 1), vsync: this);
    categoryController.setSelectedCurationIndex(0);
  }

  void changeTab(int index, BuildContext context) {
    selctedCategoryTab.value = categories[index];
    var categoryName = Uri.encodeComponent(selctedCategoryTab.value);
    isSelectedTab.value = true;
    //  Get.toNamed('/category/$categoryName');
    GoRouter.of(context).go('/category/$categoryName');
    allCurations();
    navigationStack.add(index);
  }

  var chips = [].obs;
  var curations = [].obs;
  var chips_len = [].obs;

  var searchSuggestions = [].obs;

  final isLoading = false.obs;
  final isCurationListLoading = false.obs;
  final selctedCategoryTab = "From our Desk".obs;
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
      isLoading.value = false;
      update();
    } else {
      chips = List.from([]).obs;
      isLoading.value = false;
    }
  }

  allCurations() async {
    isCurationListLoading.value = true;
    var data = {
      'category': selctedCategoryTab.value,
    };

    // print(selctedCategoryTab.value);
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
