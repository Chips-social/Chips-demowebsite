import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/location_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/success_modal.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/choice_modal.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class CreateChipModal extends StatelessWidget {
  CreateChipModal({
    super.key,
  });
  final CategoryController categoryController = Get.find<CategoryController>();
  final LocationController locationController = Get.put(LocationController());
  final ChipController chipController = Get.put(ChipController());
  final AuthController authController = Get.find<AuthController>();
  final SidebarController sidebarController = Get.find<SidebarController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        contentPadding: EdgeInsets.symmetric(
            horizontal: getW(context) < 370 ? 10 : 20, vertical: 15),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
            width: 400,
            color: ColorConst.primaryBackground,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Chip',
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
                    height: 5,
                  ),
                  Divider(color: Colors.black38),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => chipController.isLocation.value
                        ? Column(
                            children: [
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      chipController.isLocation.value = false;
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      locationController.openGoogleMaps();
                                      chipController.isLocation.value = false;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorConst.websiteHomeBox),
                                      child: Text(
                                        "Use current location",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          decorationColor: ColorConst.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: chipController.locationController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Search location',
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: fetchSuggestions,
                              ),
                              Obx(
                                () => Container(
                                  height: 240,
                                  child: ListView.builder(
                                    itemCount:
                                        chipController.suggestions.length,
                                    itemBuilder: (context, index) {
                                      final suggestion =
                                          chipController.suggestions[index];
                                      return ListTile(
                                        leading: Icon(Icons.location_on),
                                        title: Text(
                                          suggestion['description'].toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onTap: () {
                                          chipController.location.value =
                                              suggestion['description']
                                                  .toString();
                                          chipController.locationUrl.value =
                                              suggestion['mapsUrl'].toString();
                                          chipController.isLocation.value =
                                              false;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: getW(context) < 370
                                        ? 50
                                        : getW(context) < 450
                                            ? 60
                                            : 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConst.iconBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.date_range,
                                        color: ColorConst.primary,
                                        size: 16,
                                      ),
                                      onPressed: () async {
                                        // chipController.isDateTime.value = true;
                                        final DateTime? selectedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1970),
                                          lastDate: DateTime(2030),
                                        );
                                        if (selectedDate != null) {
                                          chipController.setDateTime(true);
                                          chipController.setDate(selectedDate);
                                          chipController.formattedDate.value =
                                              DateFormat('dd-MMM-yyyy')
                                                  .format(selectedDate);
                                          //print(chipController.formattedDate.value);
                                          //print(selectedDate);
                                        }
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: getW(context) < 370
                                        ? 50
                                        : getW(context) < 450
                                            ? 60
                                            : 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConst.iconBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.image,
                                        color: ColorConst.primary,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        try {
                                          _getImagefromGallery();
                                        } catch (error) {
                                          print("Error picking image: $error");
                                        }
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: getW(context) < 370
                                        ? 50
                                        : getW(context) < 450
                                            ? 60
                                            : 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConst.iconBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.location_on,
                                        color: ColorConst.primary,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        chipController.isLocation.value = true;
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: getW(context) < 370
                                        ? 50
                                        : getW(context) < 450
                                            ? 60
                                            : 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConst.iconBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.link,
                                        color: ColorConst.primary,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        //controller
                                        chipController.showUrl.value = true;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("I'm sharing this coz",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Obx(
                                    () => Text(
                                        "${chipController.counter.value}/500",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.grey,
                                          fontSize: 13,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              TextField(
                                  controller: chipController.captionController,
                                  maxLength: 500,
                                  maxLines: null,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontSize: 13,
                                  ),
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      counterText: "",
                                      hintText:
                                          "Tell your friends why you're sharing this",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      contentPadding:
                                          EdgeInsets.only(top: 5, bottom: 5)),
                                  onChanged: (value) {
                                    chipController.setCounter(value.length);
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Add #Tags",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Text("min. 1 required",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TagText(),
                              SizedBox(
                                height: 8,
                              ),
                              Obx(
                                () => chipController.formattedDate.value != ""
                                    ? Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () async {},
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.date_range,
                                                    color:
                                                        ColorConst.primaryGrey,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                      '${chipController.formattedDate}',
                                                      style: TextStyle(
                                                          color: ColorConst
                                                              .primaryGrey,
                                                          fontSize: 14)),
                                                ],
                                              )),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: ColorConst.primaryGrey,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              chipController
                                                  .formattedDate.value = "";
                                              chipController.isDateTime.value =
                                                  false;
                                            },
                                          )
                                        ],
                                      )
                                    : const SizedBox(height: 5),
                              ),
                              Obx(
                                () => chipController.location.value != ""
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: ColorConst.primaryGrey,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (!await launchUrl(
                                                        Uri.parse(chipController
                                                            .locationUrl
                                                            .value)))
                                                      throw 'Could not launch';
                                                  },
                                                  child: Container(
                                                    width: getW(context) < 400
                                                        ? getW(context) * 0.5
                                                        : getW(context) < 500
                                                            ? getW(context) *
                                                                0.55
                                                            : 320,
                                                    child: Text(
                                                        '${chipController.location}',
                                                        style: TextStyle(
                                                            color: ColorConst
                                                                .primary,
                                                            fontSize:
                                                                getW(context) <
                                                                        400
                                                                    ? 12
                                                                    : 14)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: ColorConst.primaryGrey,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              chipController.location.value =
                                                  "";
                                            },
                                          )
                                        ],
                                      )
                                    : const SizedBox(height: 5),
                              ),
                              // Obx(() => chipController.showUrl.value
                              //     ? Text("Enter Url",
                              //         style: TextStyle(
                              //           fontFamily: 'Inter',
                              //           color: Colors.white,
                              //           fontSize: 15,
                              //         ))
                              //     : Container()),
                              Obx(() => chipController.showUrl.value
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  chipController.urlController,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Rubik",
                                                fontSize: 13,
                                              ),
                                              decoration: const InputDecoration(
                                                  isDense: true,
                                                  counterText: "",
                                                  hintText: "Enter the link",
                                                  focusColor:
                                                      ColorConst.primary,
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 2, bottom: 5)),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: ColorConst.primaryGrey,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              chipController
                                                  .urlController.text = "";
                                              chipController.showUrl.value =
                                                  false;
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(height: 5)),
                              Obx(
                                () => chipController.showImagePreview.value
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.grabbing,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 155,
                                            width: 390,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                itemCount: chipController
                                                    .imageBytesList.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 150,
                                                          width: 140,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child:
                                                                  Image.memory(
                                                                chipController
                                                                        .imageBytesList[
                                                                    index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ), // Change to container
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              chipController
                                                                  .removeImage(
                                                                      index);
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(3),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40),
                                                                  color: ColorConst
                                                                      .chipBackground),
                                                              child: const Icon(
                                                                Icons.cancel,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () async {
                                    if (chipController.counter.value != 0 &&
                                        chipController.hasTags.value) {
                                      chipController.isCreatingChip.value =
                                          true;
                                      await sidebarController.myCurations();
                                      await sidebarController
                                          .mySavedCurations();

                                      Navigator.of(context).pop();
                                      saveChipAs(context);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.only(top: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: chipController
                                                            .counter.value !=
                                                        0 &&
                                                    chipController.hasTags.value
                                                ? ColorConst.primary
                                                : Colors.grey.shade700,
                                            width: 0.7)),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: chipController.counter.value !=
                                                      0 &&
                                                  chipController.hasTags.value
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            )));
  }

  void _getImagefromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'bmp',
          'webp',
          'tiff',
          'heif',
          'heic'
        ]);

    if (result != null) {
      List<PlatformFile> files = result.files;
      for (PlatformFile file in files) {
        var newImageList = List<Uint8List>.from(chipController.imageBytesList);
        Uint8List bytes = file.bytes!;
        newImageList.add(bytes);
        chipController.imageBytesList.value = newImageList;
      }
      // print("okok");
      // uploadImagesToS3(chipController.imageBytesList);
      // print("sucess");

      if (chipController.imageBytesList.isNotEmpty) {
        chipController.files = List.from(chipController.imageBytesList
            .map((bytes) => File.fromRawPath(bytes))
            .toList());
        chipController.showImagePreview.value = true;
      }
    }
  }
}

void saveChipAs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SaveChipAsModal();
    },
  );
}

void successChip(
    BuildContext context, String message, Function onTap, String btnmessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SuccessModal(
        message: message,
        onTap: onTap,
        btnmessage: btnmessage,
      );
    },
  );
}

void choiceModal(
  BuildContext context,
  String message,
  String title,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChoiceModal(
        message: message,
        title: title,
      );
    },
  );
}
