import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:chips_demowebsite/routes/routes.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId:
      '391369792833-72medeq5g0o5sklosb58k7c98ps72foj.apps.googleusercontent.com',
);
String getSubdomain() {
  final hostname = html.window.location.hostname;
  List<String> parts = hostname!.split('.');
  if (parts.length >= 3) {
    print(parts.first);
    return parts.first;
  }
  print("");
  return '';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("chips_user");
  Get.put(CategoryController());
  Get.put(AuthController());

  Get.put(HomeController());
  Get.put(SidebarController());

  Get.put(CreateCurationController());
  Get.put(ChipController());
  String initialRoute = '/';
  String? subdomain = getSubdomain();
  if (subdomain == "") {
    initialRoute = '/'; // Route for the main site
  } else {
    initialRoute = '/business'; // Route for subdomain-specific pages
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        title: 'Chips.Social',
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => Page404()),
        unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => Page404(),
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(
                Colors.grey), // Customize scrollbar thumb color
            thickness: MaterialStateProperty.all(
                8.0), // Optional: Customize scrollbar thickness
            radius: Radius.circular(8), // Optional: Customize scrollbar radius
          ),
        ),
        getPages: AppRoutes.routes);
  }
}
