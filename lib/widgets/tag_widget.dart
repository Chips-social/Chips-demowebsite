import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTags extends StatelessWidget {
  final String labelKey;
  final List<String> gridList;
  final dynamic selectedValue;
  final GetxController controller;
  final Color backgroundColor;
  final Color textColor;
  final void Function(String value) onClick;
  const MyTags({
    super.key,
    required this.labelKey,
    required this.gridList,
    required this.controller,
    required this.selectedValue,
    required this.onClick,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return gridList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: GetBuilder(
              init: controller,
              builder: (value) => Wrap(
                spacing: 10,
                children: gridList
                    .map<Widget>((chip) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              onClick(chip);
                            },
                            child: Chip(
                              color: chip == selectedValue
                                  ? MaterialStatePropertyAll(textColor)
                                  : MaterialStateProperty.all(backgroundColor),
                              label: Text(
                                chip,
                                style: TextStyle(
                                    color: chip ==selectedValue
                                        ? backgroundColor
                                        : textColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              autofocus: true,
                              side: const BorderSide(color: Colors.transparent),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
                child: Text(
              "Nothing to show ...",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            )),
          );
  }
}
