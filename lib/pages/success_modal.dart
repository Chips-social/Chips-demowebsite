import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';

class SuccessModal extends StatelessWidget {
  SuccessModal(
      {super.key,
      required this.message,
      required this.onTap,
      required this.btnmessage});
  final String message;
  final Function onTap;
  final String btnmessage;

  final HomeController homeController = Get.find<HomeController>();
  final ChipController chipController = Get.find<ChipController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 180,
                width: 350,
                color: ColorConst.primaryBackground,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Success',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                )
                              ]),
                          const SizedBox(
                            height: 6,
                          ),
                          const Divider(color: Colors.black38),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(message,
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: ColorConst.subscriptionSubtext,
                                  fontSize: 15)),
                          const SizedBox(height: 15),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15),
                          //         color: ColorConst.primary),
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 6),
                          //     child: Text(
                          //       btnmessage,
                          //       style: TextStyle(
                          //           color: ColorConst.buttonText, fontSize: 13),
                          //     ),
                          //   ),
                          // ),
                        ])))
          ],
        ));
  }
}
