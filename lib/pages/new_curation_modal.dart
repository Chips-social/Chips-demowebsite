// ignore_for_file: unused_import

import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/tag_widget.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';
import 'package:go_router/go_router.dart';

class NewCurationModal extends StatelessWidget {
  NewCurationModal({super.key});
  final CreateCurationController curationController =
      Get.put(CreateCurationController());
  final ChipController chipController = Get.put(ChipController());
  final SidebarController sidebarController = Get.find<SidebarController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        content: SingleChildScrollView(
          child: SizedBox(
              width: 420,
              child: Padding(
                padding: getW(context) < 460
                    ? const EdgeInsets.symmetric(horizontal: 0)
                    : const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                  curationController.isAlreadyExist.value
                                      ? "Curation already exists!"
                                      : 'New Curation',
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
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
                        height: 5,
                      ),
                      const Divider(color: Colors.black38),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => curationController.isAlreadyExist.value
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Great minds think alike!',
                                      style: TextStyle(
                                          color: ColorConst.primaryText,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 13)),
                                  const Text(
                                      'There are curations that already exist with the same name. You can check em out here or search for them later.',
                                      style: TextStyle(
                                          color: ColorConst.primaryText,
                                          fontFamily: 'Inter',
                                          fontSize: 13)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () =>
                                        curationController
                                                .exisitingCurators.isEmpty
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : SizedBox(
                                                height: 180,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount:
                                                        curationController
                                                            .exisitingCurators
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: ColorConst
                                                                .chipBackground),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .transparent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: Image.asset(
                                                                        "assets/website/curation_image.png",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      getW(context) <
                                                                              420
                                                                          ? 4
                                                                          : 2,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        curationController
                                                                            .curationCaptionController
                                                                            .text
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color: ColorConst
                                                                                .primary,
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                11)),
                                                                    getW(context) <
                                                                            420
                                                                        ? Text(
                                                                            'by ${curationController.exisitingCurators[index]}',
                                                                            style: const TextStyle(
                                                                                fontFamily: 'Inter',
                                                                                color: ColorConst.primary,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontSize: 9))
                                                                        : Container(),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                getW(context) >=
                                                                        420
                                                                    ? Text(
                                                                        'by ${curationController.exisitingCurators[index]}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                ColorConst.primary,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontSize: 9))
                                                                    : Container(),
                                                              ],
                                                            ), // Change to container
                                                            index == 0
                                                                ? Text(
                                                                    curationController
                                                                        .existingchips
                                                                        .value
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: ColorConst
                                                                            .primary,
                                                                        fontSize:
                                                                            12))
                                                                : Container(),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                    child: Text(
                                        'or create new curation from scratch?',
                                        style: TextStyle(
                                            color: ColorConst.primaryText,
                                            fontFamily: 'Inter',
                                            fontSize: 12)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: SizedBox(
                                          child: GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color:
                                                            ColorConst.primary,
                                                        width: 0.7)),
                                                child: Text(
                                                  "With the same name",
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      color: ColorConst.primary,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: getW(context) <
                                                              410
                                                          ? 10
                                                          : getW(context) < 470
                                                              ? 12
                                                              : 13),
                                                )),
                                          ),
                                        ),
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: SizedBox(
                                          child: GestureDetector(
                                            onTap: () async {
                                              curationController
                                                  .isAlreadyExist.value = false;
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color:
                                                            ColorConst.primary,
                                                        width: 0.7)),
                                                child: Text(
                                                  "I'll pick another name",
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      color: ColorConst.primary,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: getW(context) <
                                                              410
                                                          ? 10
                                                          : getW(context) < 470
                                                              ? 12
                                                              : 13),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('What are you curating here?',
                                      style: TextStyle(
                                          color: ColorConst.primaryText,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              getW(context) < 390 ? 13 : 16)),
                                  TextField(
                                    maxLength: 25,
                                    controller: curationController
                                        .curationCaptionController,
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white70),
                                    decoration: const InputDecoration(
                                        hintText: 'Name of this curation',
                                        hintStyle: TextStyle(
                                            color: ColorConst.primaryGrey,
                                            fontSize: 14)),
                                  ),
                                  SizedBox(height: getW(context) < 390 ? 2 : 8),
                                  const Text('Select Category',
                                      style: TextStyle(
                                          color: ColorConst.primaryText,
                                          fontFamily: 'Inter',
                                          fontSize: 16)),
                                  //list of categories to be appeared here.
                                  Obx(() => curationController.isLoading.value
                                      ? const SizedBox()
                                      : MyTags(
                                          labelKey: "interests",
                                          gridList: homeController.interests,
                                          controller: curationController,
                                          selectedValue: curationController
                                              .selectedValue.value,
                                          onClick: curationController.onChipTap,
                                          backgroundColor:
                                              ColorConst.tagBackgroundColor,
                                          textColor: ColorConst.tagTextColor,
                                        )),
                                  const Divider(
                                    color: ColorConst.dividerLine,
                                  ),
                                  SizedBox(height: getW(context) < 390 ? 2 : 8),
                                  Text('Who can see and add more to curation?',
                                      style: TextStyle(
                                          color: ColorConst.primaryText,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              getW(context) < 390 ? 12 : 16)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Obx(
                                        () => Radio(
                                          value: 'public',
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return (curationController
                                                          .visibility.value ==
                                                      'public')
                                                  ? ColorConst.primary
                                                  : Colors.white70;
                                            },
                                          ),
                                          groupValue: curationController
                                              .visibility.value,
                                          onChanged: (value) {
                                            curationController
                                                .visibility.value = value!;
                                          },
                                        ),
                                      ),
                                      const Text(
                                        'Anyone',
                                        style: TextStyle(
                                          color: ColorConst.primary,
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: getW(context) < 390 ? 10 : 20),

                                  //const SizedBox(height: 100),
                                  Obx(() => curationController
                                          .isPageLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: ColorConst.primary,
                                        ))
                                      : Row(children: [
                                          Expanded(
                                              flex: 1,
                                              child: MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: SizedBox(
                                                  height: getW(context) < 390
                                                      ? 35
                                                      : 40,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (curationController
                                                          .curationCaptionController
                                                          .text
                                                          .isEmpty) {
                                                        showErrorSnackBar(
                                                            heading:
                                                                "Field required",
                                                            message:
                                                                "Please enter curation name",
                                                            icon: Icons.person,
                                                            color:
                                                                Colors.white);
                                                      } else {
                                                        var response =
                                                            await curationController
                                                                .createCuration();
                                                        if (response ==
                                                            "exist") {
                                                          curationController
                                                              .isPageLoading
                                                              .value = false;

                                                          curationController
                                                              .isAlreadyExist
                                                              .value = true;
                                                        } else if (response ==
                                                            'success') {
                                                          curationController
                                                              .isPageLoading
                                                              .value = false;
                                                          await sidebarController
                                                              .myCurations();
                                                          showErrorSnackBar(
                                                              heading:
                                                                  "Curation created",
                                                              message:
                                                                  "You curation have been successfult created in ${curationController.selectedValue}",
                                                              icon:
                                                                  Icons.person,
                                                              color:
                                                                  Colors.white);

                                                          String categoryName =
                                                              Uri.encodeComponent(
                                                                  curationController
                                                                      .selectedValue
                                                                      .value);
                                                          String curationName =
                                                              Uri.encodeComponent(
                                                                  curationController
                                                                      .curationCaptionController
                                                                      .text);
                                                          Navigator.of(context)
                                                              .pop();

                                                          // homeController
                                                          //     .tabController
                                                          //     .animateTo(homeController
                                                          //         .categories
                                                          //         .indexOf(chipController
                                                          //             .selectedCategory
                                                          //             .value));
                                                          GoRouter.of(context).go(
                                                              '/category/$categoryName/curation/$curationName/id/${categoryController.selectedCurationId.value}');
                                                        } else {
                                                          curationController
                                                              .isPageLoading
                                                              .value = false;

                                                          showErrorSnackBar(
                                                              heading: "Error",
                                                              message:
                                                                  "Error while creating curation. Please try again",
                                                              icon:
                                                                  Icons.person,
                                                              color:
                                                                  Colors.white);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      }
                                                      // curationController
                                                      //     .isAlreadyExist
                                                      //     .value = true;

                                                      // if (curationId != null) {
                                                      //   var response =
                                                      //       await chipController
                                                      //           .addChipToCuration();
                                                      //   if (response[
                                                      //       'success']) {
                                                      //     if (context.mounted)
                                                      //       Navigator.of(
                                                      //               context)
                                                      //           .pop();
                                                      //   }
                                                      // }
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            border: Border.all(
                                                                color: ColorConst
                                                                    .primary,
                                                                width: 0.7)),
                                                        child: const Text(
                                                          "Create and Save",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              color: ColorConst
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14),
                                                        )),
                                                  ),
                                                ),
                                              ))
                                        ]))
                                ],
                              ),
                      ),
                    ]),
              )),
        ));
  }
}
