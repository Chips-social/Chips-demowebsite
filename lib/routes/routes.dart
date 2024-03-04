import 'package:chips_demowebsite/pages/category_tab.dart';
import 'package:chips_demowebsite/pages/details_page.dart';
import 'package:chips_demowebsite/pages/home.dart';
import 'package:chips_demowebsite/pages/mainpage.dart';
import 'package:chips_demowebsite/pages/my_curation_chips.dart';
import 'package:chips_demowebsite/pages/my_curations.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/pages/saved_curation_chips.dart';
import 'package:chips_demowebsite/pages/saved_curations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String homeRoute = '/category/:categoryName';
  static const String curationRoute = '/category/:categoryName/curation/:title';
  static const String mycurationRoute = '/mycuration/:title';
  static const String savedCurationRoute = '/savedcuration/:title';
  static const String pageNotFoundRoute = '/page-not-found';
  static const String myCurationChipsRoute = '/curationchips/:chip';
  static const String savedCurationChipsRoute = '/savedchips/:chip';
  // static const String categoryRoute = '/category/:categoryName';

  static final List<GetPage> routes = [
    GetPage(
      name: homeRoute,
      page: () => MainPage(child: CategoryTab(child: Home())),
    ),
    GetPage(
      name: curationRoute,
      page: () => MainPage(
          child: CategoryTab(child: DetailsPage())), // Adjust as needed
    ),
    GetPage(
      name: mycurationRoute,
      page: () => MainPage(child: MyCurations()), // Adjust as needed
    ),
    GetPage(
      name: savedCurationRoute,
      page: () => MainPage(child: SavedCurations()), // Adjust as needed
    ),
    GetPage(
      name: pageNotFoundRoute,
      page: () => Page404(),
    ),

    GetPage(
      name: myCurationChipsRoute,
      page: () => MainPage(child: MyCurationChips()),
    ),
    GetPage(
      name: savedCurationChipsRoute,
      page: () => MainPage(child: SavedCurationChips()),
    ),
    // Fallback for undefined routes
  ];
}
