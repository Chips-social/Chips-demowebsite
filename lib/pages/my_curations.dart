import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCurations extends StatefulWidget {
  MyCurations({
    super.key,
  });

  @override
  State<MyCurations> createState() => _MyCurationsState();
}

class _MyCurationsState extends State<MyCurations> {
  // List mycurations=[];
  // @override
  // void initState() {
  //   super.initState();
  //   sidebarController.myCurations().then((_) {
  //     mycurations = sidebarController.mycurations;
  //   });
  // }

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
    return Padding(
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
                      color: Color.fromRGBO(127, 62, 255, 60),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: TextButton(
                      onPressed: () {
                        newCurationModal(context);
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Text('+ New Curation',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              sidebarController.my3curations[index]['_id'];
                          await chipController.fetchchipsoCuration(context);
                          var gotourl = Uri.encodeComponent(
                              sidebarController.mycurations[index]['name']);
                          Get.toNamed('/curationchips/$gotourl');
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          color: Colors.transparent,
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
                                    ),
                                    child: Image.asset(
                                      CurationImages[homeController.categories
                                          .indexOf(sidebarController
                                              .mycurations[index]['category'])],
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
                                  sidebarController.mycurations[index]['name'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      sidebarController.mycurations[index]
                                          ['user_id']['name'],
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '',
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
            ),
          ],
        ));
  }
}
