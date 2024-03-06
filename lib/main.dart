import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/routes/routes.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("chips_user");
  Get.put(CategoryController());
  Get.put(HomeController());
  Get.put(AuthController());
  Get.put(SidebarController());

  Get.put(CreateCurationController());
  Get.put(ChipController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/category/${Uri.encodeComponent("Food & Drinks")}',
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
        ),
        getPages: AppRoutes.routes);
  }
}
