import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTags extends StatelessWidget {
  final String labelKey;
  final List<String> gridList;
  final GetxController controller;
  final Color backgroundColor;
  final Color textColor;
  final void Function(String value) onClick;
  MyTags({
    super.key,
    required this.labelKey,
    required this.gridList,
    required this.controller,
    required this.onClick,
    required this.backgroundColor,
    required this.textColor,
    required String selectedValue,
  });
  final CreateCurationController createCurationController =
      Get.find<CreateCurationController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GetBuilder(
        init: controller,
        builder: (value) => Wrap(
          spacing: 10,
          children: gridList
              .map<Widget>((chip) => Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: InkWell(
                          onTap: () {
                            onClick(chip);
                          },
                          child: Chip(
                            color: createCurationController
                                        .selectedValue.value ==
                                    chip
                                ? MaterialStatePropertyAll(textColor)
                                : MaterialStateProperty.all(backgroundColor),
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            label: Text(
                              chip,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: createCurationController
                                              .selectedValue.value ==
                                          chip
                                      ? backgroundColor
                                      : textColor,
                                  fontSize: getW(context) < 390 ? 11 : 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
