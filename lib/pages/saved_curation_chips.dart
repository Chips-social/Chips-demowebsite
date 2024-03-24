import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/create_curation_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:chips_demowebsite/widgets/empty_chips.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavedCurationChips extends StatefulWidget {
  const SavedCurationChips({super.key});

  @override
  State<SavedCurationChips> createState() => _SavedCurationChipsState();
}

class _SavedCurationChipsState extends State<SavedCurationChips> {
  final HomeController homeController = Get.put(HomeController());

  final CategoryController categoryController = Get.put(CategoryController());

  final SidebarController sidebarController = Get.find<SidebarController>();
  final ChipController chipController = Get.find<ChipController>();
  final CreateCurationController curationController =
      Get.find<CreateCurationController>();

  final String title = Get.parameters['chip'].toString();

  final String curId = Get.parameters['id'] ?? "";

  @override
  void initState() {
    super.initState();
    chipController.openCurationId.value = curId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chipController.fetchchipsoCuration(context);
      sidebarController.usernamefromChip(curId);
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
                      InkWell(
                        onTap: () {
                          var title2 = Uri.encodeComponent(title.toString());
                          showShareDialog(
                              context,
                              "http://chips.social/#/savedchips/$title2/id/$curId",
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
                      const SizedBox(width: 8),
                      homeController.selctedCategoryTab.value !=
                                  'From our Desk' &&
                              homeController.selctedCategoryTab.value !=
                                  "Made by Chips"
                          ? InkWell(
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
                              child: GestureDetector(
                                onTap: () {
                                  categoryController
                                      .selectedCurationName.value = title;
                                  createChip(context);
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
                              ),
                            )
                          : Container(),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          curationController.unsaveCuration();
                          showErrorSnackBar(
                              heading: "Curation",
                              message: "Unsaved curation",
                              icon: Icons.save,
                              color: Colors.white);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          sidebarController.savedOwnerName.value,
                          style: TextStyle(
                              fontSize: getW(context) < 400 ? 11 : 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
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
                      SizedBox(
                        width: getW(context) < 400 ? 6 : 15,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: getW(context) < 400 ? 11 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: getW(context) < 400 ? 4 : 8,
                      ),
                      InkWell(
                        onTap: () {
                          String title2 = Uri.encodeComponent(
                              homeController.selctedCategoryTab.value);
                          Get.toNamed('/category/$title2');
                        },
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(
                              horizontal: getW(context) < 400 ? 1 : 8),
                          decoration: BoxDecoration(
                              color: ColorConst.primary,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              homeController.selctedCategoryTab.value,
                              style: TextStyle(
                                  color: ColorConst.buttonText,
                                  fontSize: getW(context) < 400 ? 11 : 12,
                                  fontWeight: FontWeight.bold),
                            ),
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
              const SizedBox(height: 10),
              // screenWidth > 715
              //     ? Container()
              //     : Text(
              //         "View Collabrators",
              //         style: TextStyle(
              //             color: ColorConst.primary,
              //             fontSize: 12,
              //             fontWeight: FontWeight.bold),
              //       ),
              Obx(
                () => chipController.isLoading.value
                    ? Center(child: buildShimmerCuration(8, getW(context)))
                    : chipController.chipsofCuration.isEmpty
                        ? EmptyChipsCard(title: "chip")
                        : Expanded(
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
                                    isSavedList: chipController
                                        .chipsofCuration[index]["saved_by"],
                                    imageURLS: chipController
                                        .chipsofCuration[index]["image_urls"],
                                    url: chipController.chipsofCuration[index]
                                        ["location_desc"],
                                    locationUrl: chipController
                                        .chipsofCuration[index]["location_url"],
                                    name:
                                        '${chipController.chipsofCuration[index]["user"]["name"]}',
                                    linkUrl: chipController
                                        .chipsofCuration[index]["link_url"],
                                    likes: List<String>.from(chipController
                                        .chipsofCuration[index]["likes"]),
                                    timeAdded: DateTime.parse(chipController
                                        .chipsofCuration[index]["timeAdded"]),
                                    date: chipController.chipsofCuration[index]
                                        ["date"],
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ));
  }
}
