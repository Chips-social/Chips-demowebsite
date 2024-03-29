import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';
import 'package:chips_demowebsite/pages/new_curation_modal.dart';

class SaveChipAsModal extends StatelessWidget {
  SaveChipAsModal({super.key});
    final HomeController homeController = Get.find<HomeController>();
  final ChipController chipController = Get.find<ChipController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConst.primaryBackground,
        surfaceTintColor: ColorConst.primaryBackground,
        content: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width * 0.4,
                color: ColorConst.primaryBackground,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Save Chip As',
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: ColorConst.primary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('New Curation',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: ColorConst.subscriptionSubtext,
                                      fontSize: 18)),
                              Container(
                                  decoration: BoxDecoration(
                                    color: ColorConst.tagBackgroundColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  //padding: EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      if (context.mounted)
                                        Navigator.of(context).pop();
                                      newCurationModal(context);
                                      //Navigator.of(context).pop();

                                      //Get.to(() => NewCuration());
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: ColorConst.primary,
                                      size: 16,
                                    ),
                                  )),
                            ],
                          ),
                          /* const Divider(
                            color: ColorConst.dividerLine,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Existing Curations ',
                                  style: TextStyle(
                                      color: ColorConst.primaryGrey,
                                      fontSize: 14)),
                            ],
                          ), */
                          const SizedBox(height: 20),
                          GestureDetector(
                              onTap: () async {
                                var response = await chipController.createChip();
                                if (response['success']) {
                                    if (context.mounted) Navigator.of(context).pop();
                                  }
                                
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                     Obx(() =>Text('Save to ${categoryController.selectedCurationName}',
                                        style: TextStyle(
                                            color: ColorConst.primary,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal)),),
                                    Obx(() => chipController.isLoading.value
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 6.0,
                                              color: ColorConst.primary,
                                            ))
                                        : Icon(
                                            Icons.arrow_forward,
                                            color: ColorConst.primary,
                                            size: 24,
                                          ))
                                  ],
                                ),
                              )),
                              const SizedBox(height:8),
                            const Divider(
                  color: ColorConst.dividerLine,
                ), 
                // expansion tile list of curations to be appeared here
                 ExpansionTile(
                      title: Text('Existing Curations',
                      style:TextStyle(color: Colors.white, fontSize: 16)),
                      children: [
                        Container(
                          height:150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeController.curations.length,
                            itemBuilder: (context, index) {
                              final curation = homeController.curations[index];
                              return SingleChildScrollView(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children:[
                                        GestureDetector(
                                          onTap: () async {
                                            categoryController.setSelectedCurationName(curation['name']);
                                            categoryController.setCurationId(curation['_id']);
                                            //print("Curation ID: ${curation['_id']}");
                                            //print("Curation Name: ${categoryController.selectedCurationName}");
                                          },
                                          child: Row(
                                            children: [
                                            Text('${curation['name']}',
                                             style: const TextStyle(
                                              color: ColorConst.subscriptionSubtext,
                                              fontSize: 16)),
                                             const Spacer(),
                                             const Icon(Icons.arrow_forward, color: ColorConst.primary),
                                          ],),
                                        ),
                                         const Divider(
                                            color: ColorConst.dividerLine,
                                          ),
                                        const SizedBox(height:4),
                                      ]
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              ])))
          ],
        ));
  }

  Widget curationList(
      {required String curationId,
      required String curationName}) {
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
