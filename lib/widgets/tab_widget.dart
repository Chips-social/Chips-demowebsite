import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/widgets/empty_chips.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
  });

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
    homeController.setTabController();
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
        padding: EdgeInsets.only(left: getW(context) < 400 ? 15 : 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    homeController.selctedCategoryTab.value,
                    style: TextStyle(
                        fontSize: screenWidth < 360 ? 18 : 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConst.primary),
                  ),
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
                    Obx(
                      () => ((homeController.selctedCategoryTab.value ==
                                          "From our Desk" ||
                                      homeController.selctedCategoryTab.value ==
                                          "Made by Chips") &&
                                  authController.isLoggedIn.value &&
                                  authController.currentUser['email'] ==
                                      'meenakshi@chips.social') ||
                              (homeController.selctedCategoryTab.value !=
                                      "From our Desk" &&
                                  homeController.selctedCategoryTab.value !=
                                      "Made by Chips")
                          ? Container(
                              decoration: BoxDecoration(
                                color: ColorConst.websiteHomeBox,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: TextButton(
                                onPressed: () {
                                  authController.isLoggedIn.value
                                      ? newCurationModal(context)
                                      : showLoginDialog(context);
                                },
                                child: const Row(
                                  children: [
                                    Text('+ New Curation',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13)),
                                  ],
                                ),
                              ))
                          : Container(),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => homeController.curations.isEmpty
                    ? EmptyChipsCard(title: "curation")
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 20,
                          crossAxisCount: crossAxisCount,
                        ),
                        itemCount: homeController.curations.length,
                        itemBuilder: (context, index) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                categoryController
                                    .setSelectedCurationIndex(index);
                                categoryController.setSelectedCurationName(
                                    homeController.curations[index]["name"]);
                                categoryController.setCurationId(
                                    homeController.curations[index]["_id"]);

                                await homeController.allChips();
                                if (homeController.curations[index]['saved_by']
                                    .contains(
                                        authController.currentUser['_id'])) {
                                  curationController.isCurationSaved.value =
                                      true;
                                }
                                if (homeController.curations[index]['user_id']
                                        ['_id'] ==
                                    authController.currentUser['_id']) {
                                  curationController.isCurationOwner.value =
                                      true;
                                }

                                homeController.ownerName.value = homeController
                                    .curations[index]["user_id"]["name"];
                                var categoryName = Uri.encodeComponent(
                                    homeController.selctedCategoryTab.value);
                                var title = Uri.encodeComponent(
                                    homeController.curations[index]['name']);
                                Get.toNamed(
                                  '/category/$categoryName/curation/$title/id/${categoryController.selectedCurationId.value}',
                                );
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
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: Image.asset(
                                            homeController.CurationImages[
                                                homeController.categories
                                                    .indexOf(homeController
                                                        .selctedCategoryTab
                                                        .value)],
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
                                        homeController.curations[index][
                                            'name'], // Replace with your item title
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            homeController.selctedCategoryTab
                                                        .value ==
                                                    "From our Desk"
                                                ? ""
                                                : homeController
                                                            .curations[index]
                                                        ['user_id']['name'] ??
                                                    "Chips.Social",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '', // Replace with your chips count
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
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
      return const SaveChipAsModal();
    },
  );
}
