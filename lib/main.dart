import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/pages/home.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Chips.Social',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConst.primary),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          useMaterial3: true,
        ),
        home: ChipDemo());
  }
}
