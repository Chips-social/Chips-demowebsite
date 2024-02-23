import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/details_page.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:chips_demowebsite/widgets/curation_tab_heading.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:get_storage/get_storage.dart';

class TabWidget extends StatefulWidget {
  final String title;
  final List<dynamic> chipsList;
  final List<dynamic> curationsList;

  TabWidget(
      {super.key,
      required this.title,
      required this.chipsList,
      required this.curationsList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  List<dynamic> filteredList = [];

  final AuthController authController = Get.find<AuthController>();

  final CategoryController categoryController = Get.put(CategoryController());

  final CreateCurationController curationController =
      Get.find<CreateCurationController>();

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    categoryController.setTabController();
    double screenWidth = getW(context);
    int crossAxisCount = screenWidth > 1200
        ? 5
        : screenWidth > 950
            ? 4
            : screenWidth > 770
                ? 3
                : screenWidth > 360
                    ? 2
                    : 1;
    return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: screenWidth < 360 ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConst.primary),
                ),
                Row(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 4),
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     color: ColorConst.iconButtonColor,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         "Filter",
                    //         style: TextStyle(
                    //             color: Color.fromRGBO(127, 62, 255, 1)),
                    //       )),
                    // ),
                    // const SizedBox(width: 12),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: ColorConst.iconButtonColor,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: TextButton(
                    //       onPressed: () {
                    //         if (authController.isLoggedIn.value) {
                    //           createChip(context);
                    //         } else {
                    //           showErrorSnackBar(
                    //               heading: 'Unauthenticated User',
                    //               message: 'Please Login to add a Chip',
                    //               icon: Icons.error_outline,
                    //               color: Colors.redAccent);
                    //         }
                    //       },
                    //       child: Text(
                    //         "Sort",
                    //         style: TextStyle(
                    //             color: Color.fromRGBO(127, 62, 255, 1)),
                    //       )),
                    // ),
                    const SizedBox(width: 12),
                    Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(127, 62, 255, 60),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: TextButton(
                          onPressed: () {
                            curationController.saveCuration();
                          },
                          child: const Row(
                            children: [
                              Text('+ New Curation',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  crossAxisCount: crossAxisCount,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Get.toNamed(
                        //     "/curation/${Uri.encodeComponent(widget.title)}/curation/${Uri.encodeComponent('Item $index')}");
                        final currentNavigator = homeController
                            .getKeys()[Categories.indexOf(
                                homeController.selctedCategoryTab.value)]
                            .currentState!;
                        currentNavigator.push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            data: {
                              'chipsList': widget.chipsList,
                              'filteredList': filteredList,
                              'title': widget.title,
                            },
                          ),
                        ));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        color: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: Image.network(
                                    'assets/website/curation_image.png', // Replace with your image URL
                                    fit: BoxFit.cover,
                                    height: 150, // Adjust the height
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5),
                              child: Text(
                                'Item $index', // Replace with your item title
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Subtitle', // Replace with your item subtitle
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    '31 Chips', // Replace with your chips count
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

void createChip(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateChipModal();
    },
  );
}

void saveChipAs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SaveChipAsModal();
    },
  );
}
