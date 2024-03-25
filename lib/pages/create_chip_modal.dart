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
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class CreateChipModal extends StatefulWidget {
  const CreateChipModal({
    super.key,
  });

  @override
  State<CreateChipModal> createState() => _CreateChipModalState();
}

class _CreateChipModalState extends State<CreateChipModal> {
  final CategoryController categoryController = Get.find<CategoryController>();

  final LocationController locationController = Get.put(LocationController());

  final ChipController chipController = Get.find<ChipController>();

  final AuthController authController = Get.find<AuthController>();

  final SidebarController sidebarController = Get.find<SidebarController>();

  @override
  void initState() {
    chipController.tagController = TextfieldTagsController();
    chipController.tagController.addListener(chipController.updateHasTags);
    super.initState();
  }

  @override
  void dispose() {
    chipController.tagController.dispose();
    super.dispose();
  }

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
                        const Text('New Chip',
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
                    height: 5,
                  ),
                  const Divider(color: Colors.black38),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => chipController.isLocation.value
                        ? Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      chipController.isLocation.value = false;
                                    },
                                    child: const Icon(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorConst.websiteHomeBox),
                                      child: const Text(
                                        "Use current location",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize: 15,
                                          decorationColor: ColorConst.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: chipController.locationController,
                                style: const TextStyle(
                                    fontFamily: 'Inter', color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: 'Search location',
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: fetchSuggestions,
                              ),
                              Obx(
                                () => SizedBox(
                                  height: 240,
                                  child: ListView.builder(
                                    itemCount:
                                        chipController.suggestions.length,
                                    itemBuilder: (context, index) {
                                      final suggestion =
                                          chipController.suggestions[index];
                                      return ListTile(
                                        leading: const Icon(Icons.location_on),
                                        title: Text(
                                          suggestion['description'].toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.white),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("I'm sharing this coz",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Obx(
                                    () => Text(
                                        "${chipController.counter.value}/500",
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.grey,
                                          fontSize: 13,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                  controller: chipController.captionController,
                                  maxLength: 500,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    height: 1.5,
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                    letterSpacing: 1.1,
                                  ),
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      counterText: "",
                                      focusColor: ColorConst.primary,
                                      hoverColor: ColorConst.primary,
                                      hintText:
                                          "Tell your friends why you're sharing this",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                      contentPadding:
                                          EdgeInsets.only(top: 5, bottom: 10)),
                                  onChanged: (value) {
                                    String text = value.trim();
                                    chipController.setCounter(text.length);
                                  }),
                              const SizedBox(
                                height: 16,
                              ),
                              const Row(
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
                              const SizedBox(
                                height: 8,
                              ),
                              TextFieldTags(
                                  textfieldTagsController:
                                      chipController.tagController,
                                  textSeparators: const [' ', ','],
                                  letterCase: LetterCase.small,
                                  validator: (tag) {
                                    if (chipController.tagController.getTags!
                                        .contains(tag)) {
                                      return 'you already entered that';
                                    }
                                    return null;
                                  },
                                  inputFieldBuilder:
                                      (context, inputFieldValues) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: TextField(
                                        controller: inputFieldValues
                                            .textEditingController,
                                        focusNode: inputFieldValues.focusNode,
                                        maxLength: 12,
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontSize: 13),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          focusColor: ColorConst.primary,
                                          hoverColor: ColorConst.primary,
                                          counterText: "",
                                          contentPadding: const EdgeInsets.only(
                                              bottom: 5, top: 2),
                                          hintText: "#",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                          errorText: inputFieldValues.error,
                                          suffixIcon: inputFieldValues
                                                  .tags.isNotEmpty
                                              ? SingleChildScrollView(
                                                  controller: inputFieldValues
                                                      .tagScrollController,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                      children: inputFieldValues
                                                          .tags
                                                          .map((tag) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    20.0),
                                                              ),
                                                              color: ColorConst
                                                                  .iconBackgroundColor),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 3.0,
                                                              right: 3,
                                                              bottom: 4),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            child: Text(
                                                              tag,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13),
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                          const SizedBox(
                                                              width: 3.0),
                                                          InkWell(
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              size: 13.0,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      233,
                                                                      233,
                                                                      233),
                                                            ),
                                                            onTap: () =>
                                                                inputFieldValues
                                                                    .onTagRemoved,
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList()),
                                                )
                                              : null,
                                          suffixIconConstraints:
                                              const BoxConstraints(
                                                  maxWidth: 290),
                                        ),
                                        onChanged:
                                            inputFieldValues.onTagChanged,
                                        onSubmitted:
                                            inputFieldValues.onTagSubmitted,
                                        onTap: () =>
                                            inputFieldValues.onTagRemoved,
                                      ),
                                    );
                                  }),
                              const SizedBox(
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
                                                      style: const TextStyle(
                                                          fontFamily: 'Inter',
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
                                                            .value))) {
                                                      throw 'Could not launch';
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: getW(context) < 400
                                                        ? getW(context) * 0.5
                                                        : getW(context) < 500
                                                            ? getW(context) *
                                                                0.55
                                                            : 320,
                                                    child: Text(
                                                        '${chipController.location}',
                                                        style: TextStyle(
                                                            fontFamily: 'Inter',
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
                                      padding: const EdgeInsets.only(top: 4),
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
                                                fontFamily: "Inter",
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
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            height: 155,
                                            width: 390,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
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
                                                                  const EdgeInsets
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
                                      // print(sidebarController.mycurations);

                                      await sidebarController
                                          .mySavedCurations();

                                      await uploadImagesToS3(
                                          chipController.imageBytesList);
                                      chipController.addChipToCuration(context);
                                      Navigator.of(context).pop();

                                      // saveChipAs(context);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 5),
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
      return const SaveChipAsModal();
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
