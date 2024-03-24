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

  return SizedBox(
    height: 400,
    child: GridView.builder(
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
