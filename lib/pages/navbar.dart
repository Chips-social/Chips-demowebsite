import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';

final AuthController authController = Get.put(AuthController());
final ChipController chipController = Get.find<ChipController>();

Widget NavBar(context) {
  return Container(
    margin: EdgeInsets.only(
        left: getW(context) * 0.03,
        right: getW(context) < 450 ? 0 : getW(context) * 0.025),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getW(context) > 600
            ? InkWell(
                onTap: () async {},
                child: Image.asset('assets/website/logo.png',
                    height: 130, width: 130))
            : Container(),
        // getW(context) > 600
        //     ?r

        // : Container(),
        Obx(
          () => authController.isLoggedIn.value
              ? PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  padding: const EdgeInsets.only(left: 5),
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
                        authController.logoutUser(context);
                        break;
                      // Add more cases for other menu options
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    // PopupMenuItem<String>(
                    //   value: 'Profile',
                    //   child: Text('Profile'),
                    // ),
                    // PopupMenuItem<String>(
                    //   value: 'Settings',
                    //   child: Text('Settings'),
                    // ),
                    const PopupMenuItem<String>(
                      height: 40,
                      value: 'Logout',
                      child: Text(
                        'Logout',
                        style: TextStyle(color: ColorConst.primary),
                      ),
                    ),
                    // Add more PopupMenuItems for other options
                  ],
                  child: Initicon(
                    text: authController.currentUser['name'] ?? "Chips h",
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
                  width: getW(context) < 600
                      ? 70
                      : getW(context) < 660
                          ? 130
                          : 150,
                ),
        )
        // : Container()
      ],
    ),
  );
}
