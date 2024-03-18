import 'dart:html' as html;
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/category_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareModal extends StatelessWidget {
  final String curationLink;
  final String type;

  ShareModal({Key? key, required this.curationLink, required this.type})
      : super(key: key);
  final CategoryController categoryController = Get.find<CategoryController>();

  final HomeController homeController = Get.find<HomeController>();

  Future<void> shareWidget(String url) async {
    String encodedCurationLink = Uri.encodeComponent(curationLink);
    if (!await launchUrl(Uri.parse('$url$encodedCurationLink'))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: ColorConst.chipBackground,
      surfaceTintColor: ColorConst.chipBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Container(
        width: 500,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Spread the Magic',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: ColorConst.primaryGrey,
                    size: 15,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(height: 0.05, color: ColorConst.dark),
            const SizedBox(height: 16),
            Text(
              'Share this $type via',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await shareWidget(
                        'https://www.facebook.com/sharer/sharer.php?u=');
                  },
                  child: ShareContainer(FontAwesomeIcons.facebookF, context),
                ),
                InkWell(
                  onTap: () async {
                    await shareWidget("https://wa.me/?text=");
                  },
                  child: ShareContainer(FontAwesomeIcons.whatsapp, context),
                ),
                InkWell(
                  onTap: () async {
                    await shareWidget('https://twitter.com/intent/tweet?text=');
                  },
                  child: ShareContainer(FontAwesomeIcons.xTwitter, context),
                ),
                getW(context) > 460
                    ? InkWell(
                        onTap: () async {
                          await shareWidget('https://t.me/share/url?url=');
                        },
                        child: ShareContainer(
                            FontAwesomeIcons.telegramPlane, context),
                      )
                    : Container(),
                getW(context) > 460
                    ? InkWell(
                        onTap: () {
                          // await shareWidget("https://www.instagram.com/");
                          showErrorSnackBar(
                              heading: "Coming Soon",
                              message: "Soon you will share in instagram",
                              icon: FontAwesomeIcons.instagram,
                              color: Colors.white);
                        },
                        child:
                            ShareContainer(FontAwesomeIcons.instagram, context),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: getW(context) < 480 ? 10 : 0),
            getW(context) <= 460
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ShareContainer(
                            FontAwesomeIcons.telegramPlane, context),
                      ),
                      SizedBox(
                        width: getW(context) * 0.08,
                      ),
                      InkWell(
                        onTap: () {},
                        child:
                            ShareContainer(FontAwesomeIcons.instagram, context),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Or',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorConst.dark, width: 0.5)),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.link,
                      size: 16,
                      color: ColorConst.primary,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: curationLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Link copied to clipboard!'),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      curationLink,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: curationLink));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Link copied to clipboard!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.websiteHomeBox,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Copy',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ); // Button color
  }
}

Widget ShareContainer(icon, context) {
  return Container(
    padding: const EdgeInsets.all(16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: ColorConst.iconBackgroundColor,
        borderRadius: BorderRadius.circular(50)),
    child: Icon(
      icon,
      size: 28,
      color: ColorConst.primary,
    ),
  );
}
