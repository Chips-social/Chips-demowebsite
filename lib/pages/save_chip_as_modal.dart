import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/widgets/curation_tab_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';
import 'package:chips_demowebsite/pages/new_curation_modal.dart';

class SaveChipAsModal extends StatefulWidget {
  SaveChipAsModal({super.key});

  @override
  State<SaveChipAsModal> createState() => _SaveChipAsModalState();
}

class _SaveChipAsModalState extends State<SaveChipAsModal> {
  final HomeController homeController = Get.find<HomeController>();

  final ChipController chipController = Get.put(ChipController());

  final CategoryController categoryController = Get.find<CategoryController>();

  final SidebarController sidebarController = Get.find<SidebarController>();

  List<String> curationNames = ['My Curationd', 'Saved'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        surfaceTintColor: ColorConst.primaryBackground,
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 460,
                color: ColorConst.primaryBackground,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Save Chip',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ),
                                  )
                                ]),
                            SizedBox(
                              height: 6,
                            ),
                            Divider(color: ColorConst.dividerLine),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('New Curation',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: ColorConst.subscriptionSubtext,
                                        fontSize: 15)),
                                InkWell(
                                  onTap: () {
                                    newCurationModal(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: ColorConst.primary,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 16,
                                      )),
                                ),
                              ],
                            ),
                            Obx(
                              () => chipController.isCreatingChip.value
                                  ? SizedBox(
                                      height: 12,
                                    )
                                  : Container(),
                            ),
                            Obx(
                              () => chipController.isCreatingChip.value
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            categoryController
                                                .selectedCurationName.value,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: ColorConst
                                                    .subscriptionSubtext,
                                                fontSize: 14)),
                                        const Text('   (selected curation)',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12)),
                                        Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            await uploadImagesToS3(
                                                chipController.imageBytesList);
                                            chipController
                                                .addChipToCuration(context);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.arrow_right_alt_sharp,
                                            color: ColorConst.primary,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: TextField(
                                    controller:
                                        chipController.searchSaveController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorConst.dark,
                                      hintText: 'Search your curations',
                                      hintStyle: const TextStyle(
                                          color: ColorConst.textFieldColor,
                                          fontSize: 14),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: ColorConst.textFieldColor,
                                        size: 14,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16),
                                    ),
                                    onChanged: chipController.filterNames,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    chipController.selectedSavedCurationIndex
                                        .value = false;
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 34,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: chipController
                                                  .selectedSavedCurationIndex
                                                  .value
                                              ? ColorConst.chipBackground
                                              : Colors.white,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          "My Curation",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: chipController
                                                      .selectedSavedCurationIndex
                                                      .value
                                                  ? ColorConst.primary
                                                  : ColorConst.buttonText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    chipController.selectedSavedCurationIndex
                                        .value = true;
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 34,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: chipController
                                                  .selectedSavedCurationIndex
                                                  .value
                                              ? Colors.white
                                              : ColorConst.chipBackground,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          "Saved",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: chipController
                                                      .selectedSavedCurationIndex
                                                      .value
                                                  ? ColorConst.buttonText
                                                  : ColorConst.primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => chipController.filteredNamesC.isEmpty ||
                                      chipController
                                          .searchSaveController.text.isEmpty
                                  ? Container(
                                      height: 260,
                                      margin: EdgeInsets.only(top: 12),
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 4,
                                                childAspectRatio: 0.85),
                                        itemCount: chipController
                                                .selectedSavedCurationIndex
                                                .value
                                            ? sidebarController
                                                .mysavedCurations.length
                                            : sidebarController
                                                .mycurations.length,
                                        itemBuilder: (context, index) {
                                          var finalList = chipController
                                                  .selectedSavedCurationIndex
                                                  .value
                                              ? sidebarController
                                                  .mysavedCurations
                                              : sidebarController.mycurations;
                                          return MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                chipController.selectModalCard(
                                                    finalList[index]['name'],
                                                    finalList[index]['_id'],
                                                    finalList[index]
                                                        ['category']);
                                              },
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 0,
                                                color: Colors.transparent,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Obx(
                                                      () => Container(
                                                        height: chipController
                                                                    .selectedName
                                                                    .value ==
                                                                finalList[index]
                                                                    ['name']
                                                            ? 70
                                                            : 66,
                                                        width: chipController
                                                                    .selectedName
                                                                    .value ==
                                                                finalList[index]
                                                                    ['name']
                                                            ? 70
                                                            : 66,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: chipController
                                                                      .selectedName
                                                                      .value ==
                                                                  finalList[
                                                                          index]
                                                                      ['name']
                                                              ? LinearGradient(
                                                                  colors: [
                                                                    ColorConst
                                                                        .websiteHomeBox,
                                                                    ColorConst
                                                                        .primary,
                                                                    Colors.white
                                                                  ], // Your gradient colors
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                )
                                                              : LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white
                                                                    ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.asset(
                                                            CurationImages[homeController
                                                                .categories
                                                                .indexOf(finalList[
                                                                        index][
                                                                    'category'])],
                                                            fit: BoxFit.cover,
                                                            height:
                                                                66, // Adjust the height
                                                            width: 66,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        finalList[index]
                                                            ['name'],
                                                        style: TextStyle(
                                                            // overflow: TextOverflow
                                                            //     .ellipsis,

                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height: 260,
                                      margin: EdgeInsets.only(top: 12),
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 4,
                                                childAspectRatio: 0.85),
                                        itemCount: chipController
                                            .filteredNamesC.length,
                                        itemBuilder: (context, index) {
                                          return MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                chipController.selectModalCard(
                                                    chipController
                                                            .filteredNamesC[
                                                        index]['name'],
                                                    chipController
                                                            .filteredNamesC[
                                                        index]['_id'],
                                                    chipController
                                                            .filteredNamesC[
                                                        index]['category']);
                                              },
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 0,
                                                color: Colors.transparent,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Obx(
                                                      () => Container(
                                                        height: chipController
                                                                    .selectedName
                                                                    .value ==
                                                                chipController
                                                                        .filteredNamesC[
                                                                    index]['name']
                                                            ? 70
                                                            : 66,
                                                        width: chipController
                                                                    .selectedName
                                                                    .value ==
                                                                chipController
                                                                        .filteredNamesC[
                                                                    index]['name']
                                                            ? 70
                                                            : 66,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: chipController
                                                                      .selectedName
                                                                      .value ==
                                                                  chipController
                                                                              .filteredNamesC[
                                                                          index]
                                                                      ['name']
                                                              ? LinearGradient(
                                                                  colors: [
                                                                    ColorConst
                                                                        .websiteHomeBox,
                                                                    ColorConst
                                                                        .primary,
                                                                    Colors.white
                                                                  ], // Your gradient colors
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                )
                                                              : LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white
                                                                    ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.asset(
                                                            CurationImages[homeController
                                                                .categories
                                                                .indexOf(chipController
                                                                            .filteredNamesC[
                                                                        index][
                                                                    'category'])],
                                                            fit: BoxFit.cover,
                                                            height:
                                                                66, // Adjust the height
                                                            width: 66,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        chipController
                                                                .filteredNamesC[
                                                            index]['name'],
                                                        style: TextStyle(
                                                            // overflow: TextOverflow
                                                            //     .ellipsis,

                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ]),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          if (chipController.selectedName.isNotEmpty &&
                              chipController.selectedId.isNotEmpty) {
                            categoryController.selectedCurationName.value =
                                chipController.selectedName.value;
                            categoryController
                                .setCurationId(chipController.selectedId.value);

                            await uploadImagesToS3(
                                chipController.imageBytesList);
                            if (chipController.isCreatingChip.value) {
                              await chipController.addChipToCuration(context);
                              chipController.clearData();
                            } else {
                              await chipController.saveChipToCuration(context);
                              chipController.clearData();
                            }
                          }
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: chipController.selectedId.isEmpty
                                  ? ColorConst.dark
                                  : ColorConst.websiteHomeBox),
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: chipController.selectedId.isEmpty
                                    ? Colors.grey
                                    : Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget curationList(
      {required String curationId, required String curationName}) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () async {
              //(curationId);
              print("Curation ID: $curationId");
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    /*  ImageIcon(
                      const AssetImage(
                          "assets/background/curation_background.png"),
                      color: color,
                      size: 24,
                    ),
                    const SizedBox(width: 8), */
                    Text(curationName,
                        style: const TextStyle(
                            color: ColorConst.subscriptionSubtext,
                            fontSize: 16)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward, color: ColorConst.primary),
                  ],
                ))),
        const SizedBox(height: 12),
        const Divider(
          color: ColorConst.dividerLine,
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}

void newCurationModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NewCurationModal();
    },
  );
}
