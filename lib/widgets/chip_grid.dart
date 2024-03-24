import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/empty_chips.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChipDemo extends StatefulWidget {
  const ChipDemo({super.key, required this.title, required this.curId});
  final String title;
  final String curId;

  @override
  State<ChipDemo> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  final AuthController authController = Get.find<AuthController>();

  final CategoryController categoryController = Get.find<CategoryController>();

  final HomeController homeController = Get.find<HomeController>();

  // final String title = Get.parameters['title'] ?? "";

  // final String curId = Get.parameters['id'] ?? "";

  final CreateCurationController curationController =
      Get.put(CreateCurationController());

  @override
  void initState() {
    super.initState();
    categoryController.setCurationId(widget.curId);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.allChips();
      await homeController.allCurations();
      categoryController.selectedCurationId.value = widget.curId;
      categoryController.setSelectedCurationName(widget.title);
      for (var element in homeController.curations) {
        if (element["_id"] == widget.curId) {
          curationController.isCurationOwner.value =
              element['user_id']['_id'] == authController.currentUser['_id'];
          curationController.isCurationSaved.value =
              element['saved_by'].contains(authController.currentUser['_id']);
          break;
        }
      }
      await homeController.getUserName(widget.curId);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: screenWidth < 360 ? 18 : 24,
                          fontWeight: FontWeight.bold,
                          color: ColorConst.primary),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          var categoryName = Uri.encodeComponent(
                              homeController.selctedCategoryTab.value);
                          // var title = Uri.encodeComponent(
                          //     categoryController.selectedCurationName.value);
                          showShareDialog(
                              context,
                              "https://chips.social/category/$categoryName/curation/${widget.title}/id/${widget.curId}",
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
                            color: ColorConst.websiteHomeBox,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: getW(context) > 700 ? 12 : 8),
                      Obx(
                        () => ((homeController.selctedCategoryTab.value ==
                                            "From our Desk" ||
                                        homeController
                                                .selctedCategoryTab.value !=
                                            "Made by Chips") &&
                                    authController.isLoggedIn.value &&
                                    authController.currentUser['email'] ==
                                        'meenakshi@chips.social') ||
                                (homeController.selctedCategoryTab.value !=
                                        "From our Desk" &&
                                    homeController.selctedCategoryTab.value !=
                                        "Made by Chips")
                            ? InkWell(
                                onTap: () {
                                  if (authController.isLoggedIn.value) {
                                    createChip(context);
                                  } else {
                                    showLoginDialog(context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ColorConst.iconButtonColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: ColorConst.websiteHomeBox,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Obx(() => curationController.isCurationOwner.value
                          ? InkWell(
                              onTap: () {
                                choiceModal(
                                    context,
                                    "Are you sure you want to delete this curation? Once it is deleted, you won't be able to retrieve it back.",
                                    "Curation");
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: getW(context) < 700 ? 8 : 12),
                                padding: const EdgeInsets.only(
                                    left: 7, right: 7, top: 8, bottom: 7),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorConst.iconButtonColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/delete.svg',
                                  color: ColorConst.websiteHomeBox,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            )
                          : Obx(
                              () => (homeController.selctedCategoryTab.value ==
                                              "From our Desk" &&
                                          authController.isLoggedIn.value &&
                                          authController.currentUser['email'] ==
                                              'meenakshi@chips.social') ||
                                      (homeController
                                              .selctedCategoryTab.value !=
                                          "From our Desk")
                                  ? InkWell(
                                      onTap: () {
                                        if (curationController
                                            .isCurationSaved.value) {
                                          curationController.unsaveCuration();
                                          showErrorSnackBar(
                                              heading: "Curation",
                                              message: "Unsaved curation",
                                              icon: Icons.save,
                                              color: Colors.white);
                                        } else {
                                          if (authController.isLoggedIn.value) {
                                            curationController.saveCuration();
                                            successChip(
                                                context,
                                                "You have successfully saved a curation. You can find it in your Saved curations.",
                                                () {},
                                                "Go to saved curations");
                                          } else {
                                            showLoginDialog(context);
                                          }
                                        }
                                      },
                                      child: getW(context) > 700
                                          ? Obx(
                                              () => Container(
                                                margin: const EdgeInsets.only(
                                                    left: 12),
                                                decoration: BoxDecoration(
                                                  color: curationController
                                                          .isCurationSaved.value
                                                      ? ColorConst
                                                          .chipBackground
                                                      : const Color.fromRGBO(
                                                          127, 62, 255, 60),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 4),
                                                  child: Text(
                                                      curationController
                                                              .isCurationSaved
                                                              .value
                                                          ? 'Remove from saved'
                                                          : 'Save to my curation',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13)),
                                                ),
                                              ),
                                            )
                                          : Obx(
                                              () => Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets.only(
                                                      top: 6),
                                                  child: Image.asset(
                                                    curationController
                                                            .isCurationSaved
                                                            .value
                                                        ? 'assets/icons/group2.png'
                                                        : 'assets/icons/group.png',
                                                    width: 60,
                                                    height: 60,
                                                  )),
                                            ),
                                    )
                                  : Container(),
                            ))
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              homeController.ownerName.value,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 26,
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
                  ? buildShimmerCuration(8, getW(context))
                  : homeController.chips.isEmpty
                      ? EmptyChipsCard(title: 'chip')
                      : Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: crossAxisCount,
                            itemCount: homeController.chips.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: ChipWidget(
                                  curId: widget.curId,
                                  chipId:
                                      '${homeController.chips[index]['_id']}',
                                  text:
                                      '${homeController.chips[index]["text"]}',
                                  userId:
                                      '${homeController.chips[index]["user"]["_id"]}',
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
