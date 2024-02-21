import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChipDemo extends StatelessWidget {
  final List chipDataList;
  ChipDemo({super.key, required this.chipDataList, required this.title});
  final String title;

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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConst.iconButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Transform.rotate(
                                angle: -30 * 3.141 / 180,
                                child: Icon(
                                  Icons.send_outlined,
                                  size: 20,
                                ))),
                      ),
                      const SizedBox(width: 12),
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
                              // curationController.saveCuration();
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
                        dateTimeUrl: false,
                        imageURLS: [
                          "https://picsum.photos/seed/picsum/300/200",
                          "https://picsum.photos/id/237/200/300"
                        ],
                        showRSVP: false,
                        showNestedCard: false,
                        showYoutube: false,
                        // nestedText: "welcome to facebook",
                        // nestedTitle: "Facebook",
                        // nestedImageURL:
                        //     "https://picsum.photos/seed/picsum/300/200",
                        // url: "www.facebook.com",
                        name: '${chipDataList[index]["user"]["name"]}',
                        // youtubeURL:
                        //     "https://www.youtube.com/shorts/KAT1R4TLDQc",
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
