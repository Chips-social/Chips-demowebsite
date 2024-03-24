import 'package:chips_demowebsite/pages/category_tab.dart';
import 'package:chips_demowebsite/pages/home.dart';
import 'package:chips_demowebsite/pages/mainpage.dart';
import 'package:chips_demowebsite/pages/my_curation_chips.dart';
import 'package:chips_demowebsite/pages/my_curations.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/pages/saved_curation_chips.dart';
import 'package:chips_demowebsite/pages/saved_curations.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String routee = '/';
  // static const String routesubdom = '/business';
  static const String homeRoute = '/category/:categoryName';
  static const String curationRoute =
      '/category/:categoryName/curation/:title/id/:id';
  static const String mycurationRoute = '/mycuration/:title';
  static const String savedCurationRoute = '/savedcuration/saved';
  static const String pageNotFoundRoute = '/page-not-found';
  static const String myCurationChipsRoute = '/curationchips/:chip/id/:id';
  static const String savedCurationChipsRoute = '/savedchips/:chip/id/:id';
  // static const String categoryRoute = '/category/:categoryName';

  static final List<GetPage> routes = [
    // GetPage(
    //   name: routesubdom,
    //   page: () => const HomeMainPage(child: BusinessHomeCuration()),
    // ),
    GetPage(
      name: routee,
      page: () => const MainPage(child: CategoryTab(child: Home())),
    ),
    GetPage(
      name: homeRoute,
      page: () => const MainPage(child: CategoryTab(child: Home())),
    ),
    GetPage(
      name: curationRoute,
      page: () => const MainPage(child: CategoryTab(child: ChipDemo())),
    ),
    GetPage(
      name: mycurationRoute,
      page: () => const MainPage(child: MyCurations()),
    ),
    GetPage(
      name: savedCurationRoute,
      page: () => const MainPage(child: SavedCurations()),
    ),
    GetPage(
      name: pageNotFoundRoute,
      page: () => const Page404(),
    ),

    GetPage(
      name: myCurationChipsRoute,
      page: () => const MainPage(child: MyCurationChips()),
    ),
    GetPage(
      name: savedCurationChipsRoute,
      page: () => const MainPage(child: SavedCurationChips()),
    ),
    // Fallback for undefined routes
  ];
}
