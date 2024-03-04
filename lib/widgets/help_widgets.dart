import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
