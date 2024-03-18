import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:textfield_tags/textfield_tags.dart';

Widget PrimaryText(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: ColorConst.primary),
  );
}

Widget PrimaryBoldText(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: ColorConst.primary),
  );
}

final ChipController chipController = Get.put(ChipController());
Widget TagText() {
  return TextFieldTags(
    textfieldTagsController: chipController.tagController,
    textSeparators: const [' ', ','],
    letterCase: LetterCase.small,
    validator: (String tag) {
      if (chipController.tagController.getTags!.contains(tag)) {
        return 'you already entered that';
      }
      return null;
    },
    inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
      return ((context, sc, tags, onTagDelete) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: TextField(
            controller: tec,
            focusNode: fn,
            maxLength: 12,
            style: TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              isDense: true,
              focusColor: ColorConst.primary,
              hoverColor: ColorConst.primary,
              counterText: "",
              contentPadding: EdgeInsets.only(bottom: 5, top: 2),
              hintText: "#",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              errorText: error,
              suffixIcon: tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: sc,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: tags.map((String tag) {
                        return Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: ColorConst.iconBackgroundColor),
                          margin:
                              EdgeInsets.only(left: 3.0, right: 3, bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  '$tag',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                onTap: () {},
                              ),
                              const SizedBox(width: 3.0),
                              InkWell(
                                child: const Icon(
                                  Icons.cancel,
                                  size: 13.0,
                                  color: Color.fromARGB(255, 233, 233, 233),
                                ),
                                onTap: () {
                                  onTagDelete(tag);
                                },
                              )
                            ],
                          ),
                        );
                      }).toList()),
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(maxWidth: 290),
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        );
      });
    },
  );
}

String identifyPlatform(String url) {
  Uri uri = Uri.parse(url);
  if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
    return 'YouTube';
  }
  return 'Unknown';
}

String? extractYouTubeId(String url) {
  final RegExp youtubeRegex = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');
  final match = youtubeRegex.firstMatch(url);
  return match?.group(1); // Returns the video ID, or null if not a YouTube URL
}

Widget buildShimmerCuration(int count, double screenWidth) {
  int crossAxisCount = screenWidth > 1200
      ? 5
      : screenWidth > 950
          ? 4
          : screenWidth > 770
              ? 3
              : screenWidth > 360
                  ? 2
                  : 1;

  return GridView.builder(
    itemCount: count, // The number of items you want to display in the grid.
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: ColorConst.dark,
        // Lighter shade for the base.
        highlightColor:
            ColorConst.dividerLine, // Lighter shade for the highlight.
        // Removed the 'loop' parameter to let it shimmer indefinitely.
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey, // Base color for containers.
            borderRadius: BorderRadius.circular(
                10), // Optional: if you want rounded corners.
          ),
          // Removed fixed height and width to let the grid delegate control the size.
        ),
      );
    },
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:
          crossAxisCount, // Adjust the number of columns as per your requirement.
      crossAxisSpacing: 10,
      mainAxisSpacing:
          10, // You might want to add space between the rows as well.
      childAspectRatio: 1.5, // Adjust the aspect ratio as needed.
    ),
  );
}

Widget buildShimmerChip(int count, double screenWidth) {
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
  return GridView.builder(
    itemCount: count, // The number of items you want to display in the grid.
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: ColorConst.dark, // Lighter shade for the base.
        highlightColor:
            ColorConst.dividerLine, // Lighter shade for the highlight.
        // Removed the 'loop' parameter to let it shimmer indefinitely.
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey, // Base color for containers.
            borderRadius: BorderRadius.circular(
                10), // Optional: if you want rounded corners.
          ),
          // Removed fixed height and width to let the grid delegate control the size.
        ),
      );
    },
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:
          crossAxisCount, // Adjust the number of columns as per your requirement.
      crossAxisSpacing: 10,
      mainAxisSpacing:
          10, // You might want to add space between the rows as well.
      childAspectRatio: 0.6, // Adjust the aspect ratio as needed.
    ),
  );
}
