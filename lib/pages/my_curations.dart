import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/empty_chips.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCurations extends StatefulWidget {
  const MyCurations({
    super.key,
  });

  @override
  State<MyCurations> createState() => _MyCurationsState();
}

class _MyCurationsState extends State<MyCurations> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sidebarController.myCurations();
    });
  }

  final SidebarController sidebarController = Get.put(SidebarController());

  final ChipController chipController = Get.find<ChipController>();

  final HomeController homeController = Get.find<HomeController>();

  String title = Get.parameters['title'] ?? 'abcde';

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
        homeController.isMyCuration.value = false;
        Get.back();
        return false;
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: screenWidth < 360 ? 18 : 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConst.primary),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: ColorConst.websiteHomeBox,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TextButton(
                        onPressed: () {
                          newCurationModal(context);
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
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => sidebarController.isPageLoading.value
                    ? Center(child: buildShimmerCuration(8, getW(context)))
                    : sidebarController.mycurations.isEmpty
                        ? EmptyChipsCard(title: 'curation')
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 10,
                                crossAxisCount: crossAxisCount,
                              ),
                              itemCount: sidebarController.mycurations.length,
                              itemBuilder: (context, index) {
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      chipController.openCurationId.value =
                                          sidebarController.mycurations[index]
                                              ['_id'];
                                      await chipController
                                          .fetchchipsoCuration(context);
                                      var gotourl = Uri.encodeComponent(
                                          sidebarController.mycurations[index]
                                              ['name']);
                                      print(
                                          '/curationchips/$gotourl/id/${chipController.openCurationId.value}');
                                      Get.toNamed(
                                          '/curationchips/$gotourl/id/${chipController.openCurationId.value}');
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
                                                child: Image.asset(
                                                  homeController.CurationImages[
                                                      homeController.categories
                                                          .indexOf(sidebarController
                                                                  .mycurations[
                                                              index]['category'])],
                                                  fit: BoxFit.cover,
                                                  height: 150,
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
                                                  .mycurations[index]['name'],
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
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  sidebarController
                                                          .mycurations[index]
                                                      ['user_id']['name'],
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: Text(
                                                  '',
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
          )),
    );
  }
}
