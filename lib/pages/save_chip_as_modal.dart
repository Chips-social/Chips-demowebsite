import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart'
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';
import 'package:chips_demowebsite/pages/new_curation_modal.dart';

class SaveChipAsModal extends StatelessWidget {

  SaveChipAsModal({super.key});
  final CreateCurationController curationController = Get.put(CreateCurationController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConst.primaryBackground,
      surfaceTintColor: ColorConst.primaryBackground,
      content:Stack(
        children: [
          Container(
             height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width * 0.4,
            color: ColorConst.primaryBackground,
            child:Padding(
              padding:EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Stack(
                   children :[
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Curation',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: ColorConst.subscriptionSubtext,
                            fontSize: 18)
                        ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorConst.tagBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        //padding: EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            curationController.newCurationCheck.value= true;
                            newCurationModal(context);
                            //Get.to(() => NewCuration());
                          },
                          icon: const Icon(
                            Icons.add,
                            color: ColorConst.primary,
                            size: 16,
                          ),
                        )
                    ),
                ],),
                const Divider(
                  color: ColorConst.dividerLine,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Existing Curations ',
                  style: TextStyle(
                    color: ColorConst.primaryGrey,
                    fontSize: 14)),
                  ],),
                const SizedBox(height:50),
               /*  const Divider(
                  color: ColorConst.dividerLine,
                ), */
                ]
              )
            )
          )
        ],)
    );
    
  }
  Widget curationList(
      {required Color color,
      required String curationId,
      required String curationName}) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () async {
             (curationId);
              print("Curation ID: $curationId");
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(
                          "assets/background/curation_background.png"),
                      color: color,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
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