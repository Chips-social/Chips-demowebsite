import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:chips_demowebsite/widgets/curation_tab_heading.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MyCurationChips extends StatefulWidget {
  const MyCurationChips({super.key});
  // final String title;
  // final List chipDataList;

  @override
  State<MyCurationChips> createState() => _MyCurationChipsState();
}

class _MyCurationChipsState extends State<MyCurationChips>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  final CategoryController categoryController = Get.put(CategoryController());
  final SidebarController sidebarController = Get.find<SidebarController>();
  var myGroup = AutoSizeGroup();

  String title = Get.parameters['chip'].toString();

  // void getChips() async {
  //   await homeController.allChips();
  //   setState(() {
  //     chipsData = homeController.chips;
  //   });
  // }

  List<String> curationNames = ['All (81)', 'Mine (31)', 'Others (11)'];

  @override
  void initState() {
    super.initState();
    homeController.curationListController =
        TabController(length: 3, vsync: this);
    print(title);
  }

  @override
  void dispose() {
    super.dispose();
    homeController.curationListController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = curationNames.asMap().entries.map((entry) {
      int idx = entry.key;
      String name = entry.value;
      return Obx(() => CurationTabHeading(
            curationName: name,
            isSelected: idx == categoryController.selectedCurationIndex.value,
            curationId: 'null', // Adjust if you have specific IDs
          ));
    }).toList();

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
    return chipController.chipsofCuration.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: ColorConst.primaryBackground,
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Row(
                          children: [
                            PrimaryBoldText(
                              title,
                              24,
                            ),
                            getW(context) > 800
                                ? SizedBox(
                                    width: 10,
                                  )
                                : SizedBox(),
                            getW(context) > 700
                                ? Container(
                                    child: TabBar(
                                        isScrollable: true,
                                        controller: homeController
                                            .curationListController,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        labelColor: ColorConst.primary,
                                        labelPadding: EdgeInsets.only(
                                            left: getW(context) * 0.009),
                                        labelStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                        indicatorColor: Colors.transparent,
                                        dividerColor: Colors.transparent,
                                        onTap: (index) {
                                          categoryController
                                              .setSelectedCurationIndex(index);
                                          // if (index == 0) {
                                          //   //curationId = "null";
                                          //   categoryController.setCurationId("null");
                                          //   categoryController.setSelectedCurationName("Queue");
                                          // } else {
                                          //   filteredList = [];
                                          //   //curationId = curationsList[index - 1]["_id"];
                                          //   categoryController.setSelectedCurationName(curationsList[index-1]["name"]);
                                          //   categoryController.setCurationId(curationsList[index - 1]["_id"]);
                                          //    filteredList = chipsList
                                          //       .where(
                                          //           (chip) => chip['curation'] == curationsList[index - 1]["_id"])
                                          //       .toList();
                                          //   //categoryController.getChipList(chipsList);
                                          //   //add Filter chip list function
                                          // }
                                          // print(categoryController.selectedCurationId.value);
                                          // print(
                                          //     categoryController.selectedCurationIndex.value);
                                          // print(
                                          //     categoryController.selectedCurationName.value);
                                          //print(filteredList);
                                        },
                                        tabs: tabs),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                        color: ColorConst.chipBackground,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        dropdownColor: ColorConst.dark,
                                        isDense: true,
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        value: categoryController
                                            .selectedCurationIndex.value,
                                        style: TextStyle(color: Colors.white),
                                        items: curationNames
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return DropdownMenuItem<int>(
                                            value: entry.key,
                                            child: Text(entry.value,
                                                style: TextStyle(
                                                    color: ColorConst.primary)),
                                          );
                                        }).toList(),
                                        onChanged: (int? newIndex) {
                                          if (newIndex != null) {
                                            categoryController
                                                .setSelectedCurationIndex(
                                                    newIndex);
                                            homeController
                                                .curationListController
                                                .index = newIndex;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // getW(context) > 750 || getW(context) < 700
                          //     ?
                          // getW(context) < 380
                          //     ? Container()
                          //     : Container(
                          //         width: getW(context) < 940 ? 90 : 180,
                          //         child: RichText(
                          //           textScaler: const TextScaler.linear(1),
                          //           text: TextSpan(children: <TextSpan>[
                          //             TextSpan(
                          //               text: "Last created ",
                          //               style: TextStyle(
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: ColorConst.primary),
                          //             ),
                          //             TextSpan(
                          //                 text: "One month ago ",
                          //                 style: TextStyle(
                          //                     fontSize: 11,
                          //                     color: ColorConst.primary)),
                          //           ]),
                          //         ),
                          //       ),
                          // : Container(),
                          // : Container(),
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
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 30,
                              padding: getW(context) > 800
                                  ? EdgeInsets.symmetric(horizontal: 5)
                                  : EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  color: ColorConst.primary,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  "Food and Drinks",
                                  style: TextStyle(
                                      color: ColorConst.buttonText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   "View Collabrators",
                        //   style: TextStyle(
                        //       color: ColorConst.primary,
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
                            timeAdded: DateTime.parse(chipController
                                .chipsofCuration[index]["timeAdded"]),
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
