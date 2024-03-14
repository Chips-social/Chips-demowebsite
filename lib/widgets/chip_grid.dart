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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.allChips();
      await homeController.allCurations();
      categoryController.selectedCurationId.value = curId;
      for (var element in homeController.curations) {
        if (element["_id"] == curId) {
          curationController.isCurationOwner.value =
              element['user_id']['_id'] == authController.currentUser['_id'];
          curationController.isCurationSaved.value =
              element['saved_by'].contains(authController.currentUser['_id']);
          break;
        }
      }
      await homeController.getUserName(curId);
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
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: screenWidth < 360 ? 18 : 22,
                          fontWeight: FontWeight.bold,
                          color: ColorConst.primary),
                    ),
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
                            color: ColorConst.websiteHomeBox,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: getW(context) > 700 ? 12 : 5),
                      InkWell(
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
                          child: Icon(
                            Icons.add,
                            color: ColorConst.websiteHomeBox,
                          ),
                        ),
                      ),
                      SizedBox(width: getW(context) > 700 ? 12 : 0),
                      Obx(
                        () => curationController.isCurationOwner.value
                            ? InkWell(
                                onTap: () {
                                  choiceModal(
                                      context,
                                      "You want to delete this chip.",
                                      "Curation");
                                },
                                child: getW(context) > 700
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 4),
                                          child: Text('Delete Curation',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13)),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: ColorConst.iconButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: ColorConst.websiteHomeBox,
                                        ),
                                      ),
                              )
                            : InkWell(
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
                                          decoration: BoxDecoration(
                                            color: curationController
                                                    .isCurationSaved.value
                                                ? ColorConst.chipBackground
                                                : Color.fromRGBO(
                                                    127, 62, 255, 60),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 4),
                                            child: Text(
                                                curationController
                                                        .isCurationSaved.value
                                                    ? 'Remove from saved'
                                                    : 'Save to my curation',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13)),
                                          ),
                                        ),
                                      )
                                    : Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: SvgPicture.asset(
                                            curationController
                                                    .isCurationSaved.value
                                                ? 'assets/icons/bookmark_selected_state.svg'
                                                : 'assets/icons/bookmark_empty.svg',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                              ),
                      )
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
                            padding: EdgeInsets.only(left: 18),
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
                  ? CircularProgressIndicator()
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
                                  curId: curId,
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
