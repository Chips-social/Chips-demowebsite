import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabWidget extends StatelessWidget {
  final String title;
  TabWidget({
    super.key,
    required this.title
    });
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const SizedBox(height:32),
        Stack(
          alignment: Alignment.center,
          children:[
              Align(
                alignment:Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ColorConst.primary),
                    ),
                    TabBar(
                      controller: homeController.curationList,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: ColorConst.primary,
                      indicatorColor: ColorConst.primary,
                      tabs: [
                        Tab(
                          child: PillButton(
                          onTap: () async {},
                          text: 'All',
                          textColor: ColorConst.buttonText,
                          backGroundColor: ColorConst.primary,
                          borderColor: ColorConst.primary,
                        ),
                        ),
                        //Tab(text:'All'),
                        Tab(text: 'Blr Food Scenes'),
                        Tab(text: 'Wine & Dine Blr'),
                  ]),
                ],
                )
              ),
              Align(
                alignment:Alignment.centerRight,
                child: Container(
                        decoration: BoxDecoration(
                          color:ColorConst.iconButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color:ColorConst.buttonText
                            )
                        ),
                      ),
                )
              /* Align(
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding: const EdgeInsets.all(8),
                  child:Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:ColorConst.iconButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color:ColorConst.buttonText
                            )
                        ),
                      ),
                      const SizedBox(width:16), 
                       Container(
                        decoration: BoxDecoration(
                          color:ColorConst.iconButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send_outlined,
                            color:ColorConst.buttonText
                            )
                        ),
                      ),
                      const SizedBox(width:16),
                    ],)
                )
                ) */
            ]
          )
      ],
    )
      ) 
    );
  }
}