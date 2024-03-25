import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/empty_chips.dart';
import 'package:chips_demowebsite/widgets/empty_saved_curations.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SavedCurations extends StatefulWidget {
  const SavedCurations({super.key});

  @override
  State<SavedCurations> createState() => _SavedCurationsState();
}

class _SavedCurationsState extends State<SavedCurations> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sidebarController.mySavedCurations();
    });
  }

  String title = Get.parameters['title'] ?? 'abcde';

  final SidebarController sidebarController = Get.put(SidebarController());

  final ChipController chipController = Get.find<ChipController>();

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
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
    return WillPopScope(
      onWillPop: () async {
        homeController.isSavedCuration.value = false;
        Get.back();
        return false;
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Saved",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: getW(context) * 0.018,
                    fontWeight: FontWeight.bold,
                    color: ColorConst.primary),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => sidebarController.isPageLoading.value
                    ? Center(child: buildShimmerCuration(8, getW(context)))
                    : sidebarController.mysavedCurations.isEmpty
                        ? EmptySavedCurations()
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 10,
                                crossAxisCount: crossAxisCount,
                              ),
                              itemCount:
                                  sidebarController.mysavedCurations.length,
                              itemBuilder: (context, index) {
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      chipController.openCurationId.value =
                                          sidebarController
                                              .mysavedCurations[index]['_id'];
                                      homeController.selctedCategoryTab.value =
                                          sidebarController
                                                  .mysavedCurations[index]
                                              ['category'];
                                      chipController
                                          .fetchchipsoCuration(context);
                                      var gotourl = Uri.encodeComponent(
                                          sidebarController
                                              .mysavedCurations[index]['name']);
                                      GoRouter.of(context).go(
                                          '/savedchips/$gotourl/id/${chipController.openCurationId.value}');
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: Image.network(
                                                  homeController.CurationImages[
                                                      homeController.categories
                                                          .indexOf(sidebarController
                                                                      .mysavedCurations[
                                                                  index][
                                                              'category'])], // Replace with your image URL
                                                  fit: BoxFit.cover,
                                                  height:
                                                      150, // Adjust the height
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 5),
                                            child: Text(
                                              sidebarController
                                                      .mysavedCurations[index][
                                                  'name'], // Replace with your item title
                                              style: const TextStyle(
                                                  fontFamily: 'Inter',
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
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  sidebarController
                                                          .mysavedCurations[
                                                      index]['user_id']['name'],
                                                  style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: Text(
                                                  '', // Replace with your chips count
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
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
          )),
    );
  }
}
