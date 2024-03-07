import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChipDemo extends StatefulWidget {
  const ChipDemo({super.key});

  @override
  State<ChipDemo> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  final AuthController authController = Get.find<AuthController>();

  final CategoryController categoryController = Get.find<CategoryController>();

  final HomeController homeController = Get.find<HomeController>();

  final String title = Get.parameters['title'] ?? "";

  final String curId = Get.parameters['id'] ?? "";

  final CreateCurationController curationController =
      Get.put(CreateCurationController());

  @override
  void initState() {
    super.initState();
    categoryController.setCurationId(curId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.allChips();
    });
  }

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
                          var categoryName = Uri.encodeComponent(
                              homeController.selctedCategoryTab.value);
                          var title = Uri.encodeComponent(
                              categoryController.selectedCurationName.value);
                          showShareDialog(
                              context,
                              "http://chips.social/#/category/$categoryName/curation/$title/id/$curId",
                              "Curation");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConst.iconButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "+",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(127, 62, 255, 60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TextButton(
                            onPressed: () {
                              if (curationController.isCurationSaved.value) {
                                showErrorSnackBar(
                                    heading: "Saved curation",
                                    message:
                                        "This curation is already saved by you.",
                                    icon: Icons.save,
                                    color: Colors.white);
                              } else {
                                if (authController.isLoggedIn.value) {
                                  curationController.saveCuration(context);
                                } else {
                                  showErrorSnackBar(
                                      heading: 'Unauthenticated User',
                                      message:
                                          'Please Login to save a curation',
                                      icon: Icons.error_outline,
                                      color: Colors.redAccent);
                                }
                              }
                            },
                            child: getW(context) > 700
                                ? Text(
                                    curationController.isCurationSaved.value
                                        ? 'Saved Curation'
                                        : 'Save to my curation',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13))
                                : curationController.isCurationSaved.value
                                    ? Container()
                                    : const Icon(
                                        Icons.save,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          homeController.ownerName.value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: ColorConst.chipBackground,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
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
              const SizedBox(height: 10),
              Obx(() => homeController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : homeController.chips.isEmpty
                      ? const Center(
                          child: Card(
                            margin: EdgeInsets.only(top: 20),
                            color: ColorConst.dark,
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 40),
                              child: Text(
                                textAlign: TextAlign.center,
                                "No chips exist!\nCreate one by clicking + button at top",
                                style: TextStyle(
                                    color: Colors.white, letterSpacing: 1.4),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: crossAxisCount,
                            itemCount: homeController.chips.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: ChipWidget(
                                  chipId:
                                      '${homeController.chips[index]['_id']}',
                                  text:
                                      '${homeController.chips[index]["text"]}',
                                  isSavedList: homeController.chips[index]
                                      ["saved_by"],
                                  imageURLS: homeController.chips[index]
                                      ["image_urls"],
                                  url: homeController.chips[index]
                                      ["location_desc"],
                                  locationUrl: homeController.chips[index]
                                      ["location_url"],
                                  name:
                                      '${homeController.chips[index]["user"]["name"]}',
                                  linkUrl: homeController.chips[index]
                                      ["link_url"],
                                  likes: List<String>.from(
                                      homeController.chips[index]["likes"]),
                                  timeAdded: DateTime.parse(
                                      homeController.chips[index]["timeAdded"]),
                                  date: homeController.chips[index]["date"],
                                ),
                              );
                            },
                          ),
                        )),
            ],
          ),
        ));
  }
}
