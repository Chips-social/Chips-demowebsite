import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => getChipsView(
            curationIndex: categoryController.selectedCurationIndex.value,
            chipList: widget.data['chipsList'],
            filteredChipList: widget.data['filteredList'],
            title: widget.data['title'],
          )),
    );
  }
}

Widget getChipsView({
  required int curationIndex,
  required List<dynamic> chipList,
  required List<dynamic> filteredChipList,
  required String title,
}) {
  if (curationIndex == 0) {
    return ChipDemo(
      chipDataList: chipList,
      title: title,
    );
  } else {
    return ChipDemo(
      chipDataList: filteredChipList,
      title: title,
    );
  }
}
