// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/tag_widget.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';

class NewCurationModal extends StatelessWidget {
  NewCurationModal({super.key});
  final CreateCurationController curationController =
      Get.put(CreateCurationController());
  final ChipController chipController = Get.put(ChipController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        content: Stack(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Stack(alignment: Alignment.center, children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text('New Curation',
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: ColorConst.primary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900)),
                          )
                        ]),
                        const SizedBox(height: 24),
                        const Text('What are you curating here?',
                            style: TextStyle(
                                color: ColorConst.primaryText, fontSize: 16)),
                        TextField(
                          maxLength: 50,
                          controller:
                              curationController.curationCaptionController,
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                              hintText: 'Name of the curation',
                              hintStyle: TextStyle(
                                  color: ColorConst.primaryGrey, fontSize: 14)),
                        ),
                         const SizedBox(height: 8),
                         const Text('Select Category',
                             style: TextStyle(
                                 color: ColorConst.primaryText, fontSize: 16)),
                         //list of categories to be appeared here.
                            Obx(() => curationController.isLoading.value
                            ? const SizedBox()
                          : MyTags(
                          labelKey: "interests",
                          gridList: curationController.interests,
                          controller: curationController,
                          selectedValue: curationController.selectedValue.value,
                          onClick: curationController.onChipTap,
                          backgroundColor: ColorConst.tagBackgroundColor,
                          textColor: ColorConst.tagTextColor,
                        )), 
                        const Divider(
                    color: ColorConst.dividerLine,
                  ),
                  const SizedBox(height: 8),
                  const Text('Who can see and add more to curation?',
                      style: TextStyle(
                          color: ColorConst.primaryText, fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
    Obx(
      () => Radio(
        value: 'public',
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return (curationController.visibility.value == 'public')
              ? ColorConst.primary
              : Colors.white70;
          },
        ),
        groupValue: curationController.visibility.value,
        onChanged: (value) {
          curationController.visibility.value = value!;
        },
      ),
    ),
    const Text(
      'Anyone',
      style: TextStyle(
        color: ColorConst.primary,
        fontSize: 14,
      ),
    ),
  ],
),

                        //const SizedBox(height: 100),
Obx(() => curationController.isPageLoading.value
  ? const Center(
     child: CircularProgressIndicator(
        color: ColorConst.primary,
      ))
      : Row(children: [
          Expanded(
          flex: 1,
          child: PillButton(
                        onTap: () async {
                            var curationId = await curationController
                              .createCuration();
                        if (curationId != null) {
                          var response = await chipController
                            .addChipToCuration();
                        if (response['success']) {
                            if (context.mounted) Navigator.of(context).pop();
                        }
                      }
                    },
                    text: "Create and Save",
                    textColor: ColorConst.primary,
                    backGroundColor:
                    ColorConst.primaryBackground,
                    borderColor: ColorConst.primary,
                ),             
               )
            ]))
          ])))
        ]));
  }
}
