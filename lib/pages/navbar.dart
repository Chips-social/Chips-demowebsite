import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';

final AuthController authController = Get.put(AuthController());

Widget NavBar(context) {
  return Container(
    margin: EdgeInsets.only(
        left: getW(context) * 0.03,
        right: getW(context) < 450 ? 10 : getW(context) * 0.03),
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getW(context) > 600
            ? Image.asset('assets/icons/logo.png', height: 100, width: 100)
            : Container(),
        // getW(context) > 600
        //     ?
        SizedBox(
            width: getW(context) < 450
                ? getW(context) * 0.45
                : getW(context) * 0.4,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorConst.dark,
                hintText: 'Search',
                hintStyle: const TextStyle(
                  color: ColorConst.textFieldColor,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ColorConst.textFieldColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            )),
        // : Container(),
        Obx(() => authController.isLoggedIn.value
            ? PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                padding: EdgeInsets.all(5),
                color: ColorConst.dark,
                onSelected: (String result) {
                  switch (result) {
                    // case 'Profile':
                    //   // Handle profile action
                    //   break;
                    // case 'Settings':
                    //   // Handle settings action
                    //   break;
                    case 'Logout':
                      authController.signOutGoogle();
                      Get.toNamed('/');
                      break;
                    // Add more cases for other menu options
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  // PopupMenuItem<String>(
                  //   value: 'Profile',
                  //   child: Text('Profile'),
                  // ),
                  // PopupMenuItem<String>(
                  //   value: 'Settings',
                  //   child: Text('Settings'),
                  // ),
                  PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text(
                      'Logout',
                      style: TextStyle(color: ColorConst.primary),
                    ),
                  ),
                  // Add more PopupMenuItems for other options
                ],
                child: Initicon(
                  text: "name",
                  elevation: 4,
                  backgroundColor: ColorConst.profileBackground,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
              )
            : PillButton(
                onTap: () async {
                  showLoginDialog(context);
                },
                text: 'Login/Sign up',
                textColor: ColorConst.buttonText,
                backGroundColor: ColorConst.primary,
                borderColor: ColorConst.primary,
                height: 40,
                width: getW(context) > 600 ? 150 : 70,
              ))
        // : Container()
      ],
    ),
  );
}
