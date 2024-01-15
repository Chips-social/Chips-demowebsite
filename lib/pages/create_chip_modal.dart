import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';

class CreateChipModal extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CreateChipModal({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: [
          Container(
            height:400,
            width: 300,
            color: ColorConst.primaryBackground,
            child:Padding(
              padding:EdgeInsets.all(20),
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
                              saveChipAs(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              padding: EdgeInsets.only(
                                  left: 24.0, right: 24, top: 10, bottom: 10),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: ColorConst.buttonText, fontSize: 14),
                            )),
                      ]),
                    const SizedBox(height:10),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
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
            
                            if (selectedDate != null) {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            }
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
                              offset: Offset(0, 1),
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
                           // _getImagefromGallery();
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width:60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
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
                        width:60,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
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
                           // addChipController.showUrl.value = true;
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height:10),
                TextField(
                  //controller: addChipController.captionController,
                  maxLength: 500,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: "Write the Caption",
                      contentPadding: EdgeInsets.only(top: 5)),
                  onChanged: (value) {}
                ), 
            
              ],),
            )
          )
        ],
      )
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