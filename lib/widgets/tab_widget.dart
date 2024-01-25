import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:chips_demowebsite/widgets/curation_tab_heading.dart';
import 'package:chips_demowebsite/pages/save_chip_as_modal.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabWidget extends StatelessWidget {
  final String title;
  final List<dynamic> chipsList;
  final List<dynamic> curationsList;
  TabWidget(
      {super.key,
      required this.title,
      required this.chipsList,
      required this.curationsList});
  final AuthController authController = Get.find<AuthController>();
  final CategoryController categoryController = Get.put(CategoryController());
  var curationId;

  @override
  Widget build(BuildContext context) {
    categoryController.setTabController();
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Stack(alignment: Alignment.center, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConst.primary),
                      ),
                      TabBar(
                          controller: categoryController.curationList,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: ColorConst.primary,
                          labelPadding: const EdgeInsets.only(left: 16),
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          onTap: (index) {
                            categoryController.setSelectedCurationIndex(index);
                            if (index == 0) {
                              curationId = "null";
                            } else {
                              curationId = curationsList[index]["_id"];
                            }
                            categoryController.setCurationId(curationId);
                          },
                          tabs: [
                            Tab(
                              child: Obx(() => CurationTabHeading(
                                    curationName: 'All',
                                    isSelected: 0 ==
                                        categoryController
                                            .selectedCurationIndex.value,
                                    curationId: 'null',
                                  )),
                            ),
                            //Tab(text:'All'),
                            for (var i = 0; i < curationsList.length; i++)
                              Tab(
                                child: Obx(() => CurationTabHeading(
                                      curationName: curationsList[i]["name"],
                                      isSelected: (i + 1) ==
                                          categoryController
                                              .selectedCurationIndex.value,
                                      curationId: curationsList[i]["_id"],
                                    )),
                              ),
                            /*  Tab(
                              child: Obx(() => CurationTabHeading(
                                  curationName: 'Blr Food Scenes',
                                  isSelected: 1 ==
                                      categoryController
                                          .selectedCurationIndex.value,
                                  curationId: "id1",)),
                            ),
                            Tab(
                              child: Obx(() => CurationTabHeading(
                                  curationName: 'Wine & Dine Blr',
                                  isSelected: 2 ==
                                      categoryController
                                          .selectedCurationIndex.value,
                                  curationId: "id2")),
                            ),  */
                          ]),
                    ],
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorConst.iconButtonColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                                onPressed: () {
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
                                icon: const Icon(Icons.add,
                                    color: ColorConst.buttonText)),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorConst.iconButtonColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send_outlined,
                                    color: ColorConst.buttonText)),
                          ),
                          const SizedBox(width: 16),
                          Container(
                              decoration: BoxDecoration(
                                color: ColorConst.iconButtonColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst
                                        .iconButtonColor, // Set the background color
                                    fixedSize: const Size(
                                        120, 40), // Set the height and width
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.save),
                                      //SizedBox(width: 4),
                                      Text('Save',
                                          style: TextStyle(
                                              color: ColorConst
                                                  .selectedTabHeadingColor,
                                              fontSize: 16)),
                                    ],
                                  )))
                        ],
                      )))
            ]),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: categoryController.curationList,
              children: [
                for (var i = 0; i < curationsList.length + 1; i++)
                  ChipDemo(
                    chipDataList: chipsList,
                  ),
                // Container(
                //   child: const Text('a'),
                // ),
                // Container(
                //   child: const Text('a'),
                // ),
              ],
            ))
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
