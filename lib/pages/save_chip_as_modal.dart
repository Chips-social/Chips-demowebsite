import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/pages/new_curation_modal.dart';

class SaveChipAsModal extends StatefulWidget {
  const SaveChipAsModal({super.key});

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
    int crossAxisCount = getW(context) > 530
        ? 4
        : getW(context) > 400
            ? 3
            : 2;
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        surfaceTintColor: ColorConst.primaryBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 420,
                color: ColorConst.primaryBackground,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Save Chip',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
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
                            const Divider(color: ColorConst.dividerLine),
                            const SizedBox(
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
                                      padding: const EdgeInsets.all(3),
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
                                  ? const SizedBox(
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
                                            style: const TextStyle(
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
                                        const Spacer(),
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
                            const SizedBox(height: 20),
                            getW(context) <= 440
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    width: 240,
                                    child: TextField(
                                      controller:
                                          chipController.searchSaveController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        filled: true,
                                        isDense:
                                            getW(context) < 500 ? true : false,
                                        fillColor: ColorConst.dark,
                                        hintText: 'Search your curations',
                                        hintStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorConst.textFieldColor,
                                            fontSize:
                                                getW(context) < 440 ? 11 : 14),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: ColorConst.textFieldColor,
                                          size: getW(context) < 440 ? 11 : 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 16),
                                      ),
                                      onChanged: chipController.filterNames,
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: getW(context) <= 440
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getW(context) > 440
                                    ? SizedBox(
                                        width: getW(context) < 530
                                            ? 180
                                            : getW(context) < 440
                                                ? 150
                                                : 240,
                                        child: TextField(
                                          controller: chipController
                                              .searchSaveController,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                            filled: true,
                                            isDense: getW(context) < 500
                                                ? true
                                                : false,
                                            fillColor: ColorConst.dark,
                                            hintText: 'Search your curations',
                                            hintStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    ColorConst.textFieldColor,
                                                fontSize: getW(context) < 440
                                                    ? 11
                                                    : 14),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: ColorConst.textFieldColor,
                                              size:
                                                  getW(context) < 440 ? 11 : 14,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 16),
                                          ),
                                          onChanged: chipController.filterNames,
                                        ),
                                      )
                                    : Container(
                                        width: 1,
                                      ),
                                InkWell(
                                  onTap: () {
                                    chipController.selectedSavedCurationIndex
                                        .value = false;
                                  },
                                  child: Obx(
                                    () => Container(
                                      margin: EdgeInsets.only(
                                          right: getW(context) <= 440 ? 8 : 0),
                                      height: 34,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getW(context) < 530 ? 3 : 8),
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
                                      margin: EdgeInsets.only(
                                          left: getW(context) < 530 ? 10 : 0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getW(context) < 530 ? 3 : 8),
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
                                      margin: const EdgeInsets.only(top: 12),
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: crossAxisCount,
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
                                                              ? const LinearGradient(
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
                                                              : const LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white
                                                                    ]),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.asset(
                                                            homeController
                                                                    .CurationImages[
                                                                homeController
                                                                    .categories
                                                                    .indexOf(finalList[
                                                                            index]
                                                                        [
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
                                                      width: 70,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        finalList[index]
                                                            ['name'],
                                                        style: const TextStyle(
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
                                      margin: const EdgeInsets.only(top: 12),
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: crossAxisCount,
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
                                                            ? 72
                                                            : 66,
                                                        width: chipController
                                                                    .selectedName
                                                                    .value ==
                                                                chipController
                                                                        .filteredNamesC[
                                                                    index]['name']
                                                            ? 72
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
                                                              ? const LinearGradient(
                                                                  stops: [
                                                                    0.5,
                                                                    1.0
                                                                  ],
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
                                                              : const LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white
                                                                    ]),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.asset(
                                                            homeController
                                                                    .CurationImages[
                                                                homeController
                                                                    .categories
                                                                    .indexOf(chipController
                                                                            .filteredNamesC[index]
                                                                        [
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
                                                      width: 70,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        chipController
                                                                .filteredNamesC[
                                                            index]['name'],
                                                        style: const TextStyle(
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
                          if (chipController.selectedChipId.value ==
                                  'Made by Chips' ||
                              chipController.selectedChipId.value ==
                                  'From our Desk') {
                            showErrorSnackBar(
                                heading: "Permision Denied",
                                message:
                                    "Don't have permission to save chip in this curation.",
                                icon: Icons.warning,
                                color: Colors.white);
                          } else {
                            if (chipController.selectedName.isNotEmpty &&
                                chipController.selectedId.isNotEmpty) {
                              var oldvalue =
                                  categoryController.selectedCurationName.value;
                              categoryController.selectedCurationName.value =
                                  chipController.selectedName.value;
                              categoryController.setCurationId(
                                  chipController.selectedId.value);
                              if (chipController.isCreatingChip.value) {
                                await uploadImagesToS3(
                                    chipController.imageBytesList);
                                await chipController.addChipToCuration(context);
                                chipController.clearData();
                                categoryController.selectedCurationName.value =
                                    oldvalue;
                              } else {
                                await chipController
                                    .saveChipToCuration(context);
                                chipController.clearData();
                                categoryController.selectedCurationName.value =
                                    oldvalue;
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 420,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: chipController.selectedId.isEmpty
                                  ? ColorConst.dark
                                  : ColorConst.websiteHomeBox),
                          alignment: Alignment.center,
                          child: Text(
                            chipController.isLoading.value
                                ? "Please Wait..."
                                : "Save",
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
