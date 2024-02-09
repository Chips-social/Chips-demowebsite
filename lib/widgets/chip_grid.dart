import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:chips_demowebsite/widgets/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChipDemo extends StatelessWidget {
  final List chipDataList;
  ChipDemo({super.key, required this.chipDataList});
  // final chipDataList = [
  //   ChipWidget(
  //     text: 'Hello this is my new chip 1',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "Anju",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 2',
  //     dateTimeUrl: false,
  //     imageURLS: ["https://picsum.photos/seed/picsum/300/200"],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 1',
  //     dateTimeUrl: false,
  //     imageURLS: ['https://picsum.photos/seed/picsum/200/300'],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "Anju",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 2',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 3',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "Anju",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 4',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 6',
  //     dateTimeUrl: false,
  //     imageURLS: [
  //       "https://picsum.photos/seed/picsum/300/200",
  //       "https://picsum.photos/id/237/200/300",
  //     ],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "Anju",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   ),
  //   ChipWidget(
  //     text: 'Hello this is my new chip 8 qith some logs testmssnslkvnslkvnl',
  //     dateTimeUrl: false,
  //     imageURLS: [],
  //     showRSVP: false,
  //     showNestedCard: false,
  //     showYoutube: false,
  //     name: "John",
  //     timeAdded: DateTime.now(),
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.primaryBackground,
        body: Padding(
            padding: EdgeInsets.zero,
            child: MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: chipDataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ChipWidget(
                        chipId:'${chipDataList[index]['_id']}',
                        text: '${chipDataList[index]["text"]}',
                        dateTimeUrl: false,
                        imageURLS: [],
                        showRSVP: false,
                        showNestedCard: false,
                        showYoutube: false,
                        url:'${chipDataList[index]["url"]}',
                        name: '${chipDataList[index]["user"]["name"]}',
                        likes: List<String>.from(chipDataList[index]["likes"]),
                        timeAdded:
                            DateTime.parse(chipDataList[index]["timeAdded"]),
                        date: '${chipDataList[index]["date"] != null ? chipDataList[index]["date"] : ''}'
                      ));
                })));
  }
}
