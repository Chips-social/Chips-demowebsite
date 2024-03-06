import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:chips_demowebsite/widgets/curation_tab_heading.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SavedCurationChips extends StatelessWidget {
  SavedCurationChips({super.key});

  final HomeController homeController = Get.put(HomeController());

  final CategoryController categoryController = Get.put(CategoryController());

  String title = Get.parameters['chip'].toString();

  @override
  Widget build(BuildContext context) {
    double screenWidth = getW(context);
    int crossAxisCount = screenWidth > 1300
        ? 4
        : screenWidth > 1050
            ? 3
            : screenWidth > 760
                ? 2
                : screenWidth > 600
                    ? 1
                    : screenWidth < 490
                        ? 1
                        : 2;
    return Container(
        padding: EdgeInsets.only(left: 30, right: getW(context) * 0.01),
        color: ColorConst.primaryBackground,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PrimaryBoldText(
                        title,
                        24,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConst.iconButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Transform.rotate(
                              angle: -30 * 3.141 / 180,
                              child: Icon(
                                Icons.send_outlined,
                                size: 20,
                              )),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // if (authController.isLoggedIn.value) {
                          //   createChip(context);
                          // } else {
                          //   showErrorSnackBar(
                          //       heading: 'Unauthenticated User',
                          //       message: 'Please Login to add a Chip',
                          //       icon: Icons.error_outline,
                          //       color: Colors.redAccent);
                          // }
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConst.iconButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 35,
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) < 400 ? 3 : 10),
                        decoration: BoxDecoration(
                            color: ColorConst.chipBackground,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Remove from Saved",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getW(context) < 400 ? 12 : 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Paloma J",
                        style: TextStyle(
                            fontSize: getW(context) < 400 ? 11 : 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: getW(context) < 400 ? 4 : 8,
                      ),
                      Container(
                        height: 28,
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) < 400 ? 2 : 5),
                        decoration: BoxDecoration(
                            color: ColorConst.chipBackground,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Subscribed",
                            style: TextStyle(
                                color: Color.fromARGB(198, 255, 255, 255),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getW(context) < 400 ? 6 : 15,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: getW(context) < 400 ? 11 : 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: getW(context) < 400 ? 4 : 8,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) < 400 ? 1 : 5),
                        decoration: BoxDecoration(
                            color: ColorConst.primary,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Food and Drinks",
                            style: TextStyle(
                                color: ColorConst.buttonText,
                                fontSize: getW(context) < 400 ? 11 : 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // screenWidth < 715
                  //     ? Container()
                  //     : Text(
                  //         "View Collabrators",
                  //         style: TextStyle(
                  //             color: ColorConst.primary,
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                ],
              ),
              SizedBox(height: 10),
              // screenWidth > 715
              //     ? Container()
              //     : Text(
              //         "View Collabrators",
              //         style: TextStyle(
              //             color: ColorConst.primary,
              //             fontSize: 12,
              //             fontWeight: FontWeight.bold),
              //       ),
              Expanded(
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: crossAxisCount,
                  itemCount: chipController.chipsofCuration.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ChipWidget(
                        chipId:
                            '${chipController.chipsofCuration[index]['_id']}',
                        text:
                            '${chipController.chipsofCuration[index]["text"]}',
                        isSavedList: chipController.chipsofCuration[index]
                            ["saved_by"],
                        imageURLS: chipController.chipsofCuration[index]
                            ["image_urls"],
                        url: chipController.chipsofCuration[index]
                            ["location_desc"],
                        locationUrl: chipController.chipsofCuration[index]
                            ["location_url"],
                        name:
                            '${chipController.chipsofCuration[index]["user"]["name"]}',
                        linkUrl: chipController.chipsofCuration[index]
                            ["link_url"],
                        likes: List<String>.from(
                            chipController.chipsofCuration[index]["likes"]),
                        timeAdded: DateTime.parse(
                            chipController.chipsofCuration[index]["timeAdded"]),
                        date: chipController.chipsofCuration[index]["date"],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
