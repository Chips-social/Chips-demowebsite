import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: '391369792833-72medeq5g0o5sklosb58k7c98ps72foj.apps.googleusercontent.com',
  //clientSecret:"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" // Use your client ID
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
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
