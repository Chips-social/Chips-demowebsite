import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';

class SaveChipAsModal extends StatelessWidget {

  SaveChipAsModal({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:Stack(
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
                           // Get.to(() => NewCuration());
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
                const Divider(
                  color: ColorConst.dividerLine,
                ),
                const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Save to Queue',
                              style: TextStyle(
                                  color: ColorConst.primary,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal)),
                           Icon(
                                  Icons.arrow_forward,
                                  color: ColorConst.primary,
                                  size: 24,
                                ),
                        ],
                      )

                ]
              )
            )
          )
        ],)
    );
  }
}