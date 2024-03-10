import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/login_modal.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/share_modal.dart';
//import 'package:chips_demowebsite/widgets/share_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final HomeController homeController = Get.put(HomeController());
Widget HomeStartCard(context) {
  return Container(
    height: 220,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConst.websiteHomeBox),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      // SlideTransition(
      //      position: homeController.animation,
      //     child:
      Image.asset('assets/website/website_card.png',
          height: 50, width: getW(context) > 600 ? 200 : 150),
      // ),
      Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Welcome to Chips 👋',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getW(context) > 600 ? 16 : 12,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Save your favourites and Curate Your Internet.',
                  style: TextStyle(color: ColorConst.primary, fontSize: 14)),
              const SizedBox(height: 10),
              PillButton(
                  onTap: () async {
                    newCurationModal(context);
                  },
                  text: 'Start curating',
                  textColor: Colors.black,
                  width: 140,
                  height: 30,
                  backGroundColor: ColorConst.primary)
            ],
          ))
    ]),
  );
}

void showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Modal();
    },
  );
}

/* void showShareDialog(BuildContext context, String link, String type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ShareModal(
        curationLink: link,
        type: type,
      );
    },
  );
} */

void showShareDialog(BuildContext context, String link, String type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ShareModal(
        curationLink: link,
        type: type,
      );
    },
  );
}

void createChip(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateChipModal();
    },
  );
}

void saveChip(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SaveChipAsModal();
    },
  );
}
