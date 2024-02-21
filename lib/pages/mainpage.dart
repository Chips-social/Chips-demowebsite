import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/pages/sidebar.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({required this.child});
  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    bool isNarrowScreen = MediaQuery.of(context).size.width <= 600;
    return Scaffold(
      backgroundColor: ColorConst.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 100,
        leadingWidth: getW(context) > 400 ? 70 : 40,
        elevation: 0,
        title: NavBar(context),
      ),
      drawer: isNarrowScreen ? SideBar() : null,
      body: Padding(
        padding: EdgeInsets.only(right: getW(context) * 0.03),
        child: Stack(
          children: [
            getW(context) > 600
                ? Positioned(
                    top: 30,
                    bottom: 0,
                    left: 0,
                    child: SideBar(),
                  )
                : Container(),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: NavBar(context),
            // ),
            Positioned(
              top: 20,
              bottom: 0,
              left: getW(context) > 600 ? 200 : 0,
              right: 0,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
