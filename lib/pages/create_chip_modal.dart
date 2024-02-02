import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:io';

class CreateChipModal extends StatelessWidget {
  CreateChipModal({
    super.key,
    FilePickerResult? result,
    List? File,
  });
  final CategoryController categoryController = Get.find<CategoryController>();
  final ChipController chipController = Get.put(ChipController());
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        content: Container(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width * 0.4,
            color: ColorConst.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    const Text(
                      "New Chip",
                      style: TextStyle(
                          color: ColorConst.primaryText, fontSize: 20),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          if (chipController.showPreview.value ||
                              chipController.showImagePreview.value) {
                            if (context.mounted) Navigator.of(context).pop();
                            saveChipAs(context);

                            //var response = await chipController.createChip();
                            /*  if (response["success"]) {
                              if (context.mounted) Navigator.of(context).pop();
                            } */
                          } else {
                            showErrorSnackBar(
                                heading: "Error",
                                message:
                                    "Can't save empty Chip. Add some fields please",
                                icon: Icons.error,
                                color: Colors.redAccent);
                          }
                          // if (chipController.showPreview.value ||
                          //     chipController.showImagePreview.value) {
                          //   if (categoryController
                          //           .selectedCurationIndex.value ==
                          //       0) {
                          //     saveChipAs(context);
                          //   } else {
                          //     showErrorSnackBar(
                          //         heading: "Error",
                          //         message:
                          //             "Can't save empty Chip. Add some fields please",
                          //         icon: Icons.error,
                          //         color: Colors.redAccent);
                          //   }
                          // } else {
                          //   chipController.addChipToCuration();
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24, top: 10, bottom: 10),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              color: ColorConst.buttonText, fontSize: 14),
                        )),
                  ]),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          color: ColorConst.iconBackgroundColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.date_range,
                            color: ColorConst.primary,
                            size: 20,
                          ),
                          onPressed: () async {
                            //controller
                            final DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2030),
                            );
                            if(selectedDate != null){
                              chipController.setDateTime(true);
                              chipController.setDate(selectedDate);
                              //print(selectedDate);
                            }
                           /*   if (selectedDate != null) {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ); 
                            } */
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          color: ColorConst.iconBackgroundColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: ColorConst.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            _getImagefromGallery();
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          color: ColorConst.iconBackgroundColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.location_on,
                            color: ColorConst.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            //controller
                            // addChipController.showLocationField.value = true;
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          color: ColorConst.iconBackgroundColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.link,
                            color: ColorConst.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            //controller
                            chipController.showUrl.value = true;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: chipController.captionController,
                      maxLength: 500,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Write the Caption",
                          contentPadding: EdgeInsets.only(top: 5)),
                      onChanged: (value) {
                        if (value.trim().isEmpty) {
                          chipController.setPreview(false);
                          chipController.setPreview(value.trim().isNotEmpty);
                        } else {
                          chipController.setPreview(false);
                          chipController.setPreview(true);
                        }
                      }),
                  Obx(() => chipController.showImagePreview.value
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0;
                                    i < chipController.imageBytesList.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: getImagePreview(
                                        bytes: chipController.imageBytesList[i],
                                        index: i),
                                  ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()),
                  Obx(() => chipController.showPreview.value
                      ? getPreview(
                          caption: chipController.captionController.text,
                          name: authController.getCurrentUser()["name"],
                          selectedDate:chipController.selectedDate.value.toString(),
                          )
                      : const SizedBox()),
                Obx(() => chipController.showUrl.value
                ? Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Expanded(
                              child: 
                              TextField(
                                controller: chipController.urlController ,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Enter the Url",
                                    contentPadding: EdgeInsets.only(top: 15)),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: ColorConst.dark,
                                size: 20,
                              ),
                              onPressed: () {
                                chipController.showUrl.value = false;
                              },
                            )
                          ],
                        )
                      ],
                    ))
                : const SizedBox()),
                ],
              ),
            )));
  }

  Widget getPreview({required String caption, required String name, required String selectedDate}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ChipWidget(
          text: caption,
          dateTimeUrl: false,
          imageURLS: [],
          showRSVP: false,
          showNestedCard: false,
          showYoutube: false,
          name: name,
          //name: '${authController.getCurrentUser()["name"] ?? "User Name"}',
          timeAdded: DateTime.now(),
          date: selectedDate,
        ));
  }

  void _uploadImagesToS3(List<Uint8List> imageBytesList) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5555/api/upload'),
    );

    for (int i = 0; i < imageBytesList.length; i++) {
      var bytes = imageBytesList[i];
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'image$i.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Images uploaded successfully');
      } else {
        print('Error uploading images: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception uploading images: $e');
    }
  }

  void _getImagefromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    /*    if (result != null) {
    PlatformFile file = result.files.first; // Get the first selected file
    Uint8List imageBytes = file.bytes!; */

    if (result != null) {
      List<PlatformFile> files = result.files;
      List<Uint8List> imageBytesList = [];

      for (PlatformFile file in files) {
        imageBytesList.add(file.bytes!);
        Uint8List bytes = file.bytes!;
        chipController.imageBytesList.add(bytes);
      }
      _uploadImagesToS3(imageBytesList);

      if (chipController.imageBytesList.isNotEmpty) {
        chipController.files = List.from(chipController.imageBytesList
            .map((bytes) => File.fromRawPath(bytes))
            .toList());
        chipController.showImagePreview.value = true;
      }
    }
    /*   if (result != null) {
       chipController.files =
          List.from(result.paths.map((path) => File(path!)).toList());
      if (chipController.files.isNotEmpty) {
        chipController.showImagePreview.value = true;
      }
    } */
  }

  Widget getImagePreview({required Uint8List bytes, required int index}) {
    return Stack(
      children: <Widget>[
        Container(
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // Set desired radius
            child: Image.memory(bytes),
          ),
        ), // Change to container
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              chipController.removeImage(index);
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
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
