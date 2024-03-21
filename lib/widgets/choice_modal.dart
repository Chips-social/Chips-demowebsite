import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';

class ChoiceModal extends StatelessWidget {
  ChoiceModal({
    super.key,
    required this.message,
    required this.title,
  });
  final String message;
  final String title;

  final HomeController homeController = Get.find<HomeController>();
  final ChipController chipController = Get.find<ChipController>();
  final CreateCurationController curationController =
      Get.find<CreateCurationController>();
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
                width: 330,
                color: ColorConst.primaryBackground,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) < 330 ? 2 : 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Action Confirmation',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: ColorConst.textFieldColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.of(context).pop();
                                //   },
                                //   child: const Icon(
                                //     Icons.close,
                                //     color: Colors.grey,
                                //   ),
                                // )
                              ]),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(message,
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: ColorConst.textFieldColor,
                                  fontSize: 15)),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorConst.primary),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getW(context) < 400 ? 15 : 24,
                                      vertical: 12),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: ColorConst.buttonText,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  if (title == "Curation") {
                                    await curationController.deleteCuration();
                                    showErrorSnackBar(
                                        heading: "Deleted curation",
                                        message:
                                            "Your Curation has been deleted.",
                                        icon: Icons.delete,
                                        color: Colors.white);
                                  } else {
                                    await chipController.deleteChip();
                                    showErrorSnackBar(
                                        heading: "Deleted chip",
                                        message: "Your Chip has been deleted.",
                                        icon: Icons.delete,
                                        color: Colors.white);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: ColorConst.primary)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getW(context) < 400 ? 15 : 20,
                                      vertical: 12),
                                  child: Text(
                                    "Yes, delete",
                                    style: TextStyle(
                                        color: ColorConst.primary,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ])))
          ],
        ));
  }
}
