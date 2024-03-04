import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChipDemo extends StatelessWidget {
  final List chipDataList;
  ChipDemo({super.key, required this.chipDataList, required this.title});
  final String title;

  final AuthController authController = Get.find<AuthController>();
  final CreateCurationController curationController =
      Get.find<CreateCurationController>();
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
        color: ColorConst.primaryBackground,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: screenWidth < 360 ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: ColorConst.primary),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showShareDialog(context, "weec", "Curation");
                          // showErrorSnackBar(
                          //     heading: "Account Saved",
                          //     message: "gdndkvnd",
                          //     icon: Icons.account_balance,
                          //     color: Colors.white);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 9, right: 9, top: 11, bottom: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConst.iconButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/share_icon.svg',
                            color: Colors.black,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (authController.isLoggedIn.value) {
                            createChip(context);
                          } else {
                            showErrorSnackBar(
                                heading: 'Unauthenticated User',
                                message: 'Please Login to add a Chip',
                                icon: Icons.error_outline,
                                color: Colors.redAccent);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConst.iconButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(127, 62, 255, 60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextButton(
                            onPressed: () {
                              if (authController.isLoggedIn.value) {
                                curationController.saveCuration(context);
                              } else {
                                showErrorSnackBar(
                                    heading: 'Unauthenticated User',
                                    message: 'Please Login to save a curation',
                                    icon: Icons.error_outline,
                                    color: Colors.redAccent);
                              }
                            },
                            child: getW(context) > 700
                                ? Text('Save to my curation',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13))
                                : Icon(
                                    Icons.save,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Paloma J",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 28,
                          padding: EdgeInsets.symmetric(horizontal: 5),
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
                      ],
                    ),
                    Text(
                      "View Collabrators",
                      style: TextStyle(
                          color: ColorConst.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: crossAxisCount,
                  itemCount: chipDataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ChipWidget(
                        chipId: '${chipDataList[index]['_id']}',
                        text: '${chipDataList[index]["text"]}',
                        dateTimeUrl: true,
                        imageURLS: [
                          "https://picsum.photos/seed/picsum/300/200",
                          "https://picsum.photos/id/237/200/300"
                        ],
                        showUrl: true,
                        url: "www.facebook.com",
                        name: '${chipDataList[index]["user"]["name"]}',
                        linkUrl: "https://www.youtube.com/watch?v=e3uBz-PAZQ4",
                        likes: List<String>.from(chipDataList[index]["likes"]),
                        timeAdded:
                            DateTime.parse(chipDataList[index]["timeAdded"]),
                        date: '2024-02-13',
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
