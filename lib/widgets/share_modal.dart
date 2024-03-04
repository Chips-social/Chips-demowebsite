import 'dart:convert';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;

class ShareModal extends StatelessWidget {
  final String curationLink;
  final String type;

  ShareModal({Key? key, required this.curationLink, required this.type})
      : super(key: key);

  Future<void> shareToWhatsApp() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/share'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': 'snsns',
          'description': "dcnd",
          'imageUrl':
              "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png",
        }),
      );

      if (response.statusCode == 200) {
        final shareUrl = jsonDecode(response.body)['shareUrl'];
        final whatsAppurl =
            Uri.parse('https://wa.me/?text=${Uri.encodeComponent(shareUrl)}');
        await canLaunchUrl(whatsAppurl)
            ? await launchUrl(whatsAppurl)
            : throw 'Could not launch $shareUrl';
      } else {
        throw 'Failed to load share url';
      }
    } catch (e) {
      // Handle the error
      print(e);
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
        padding: EdgeInsets.all(16),
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
                Text(
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
                  child: Icon(
                    Icons.close,
                    color: ColorConst.primaryGrey,
                    size: 15,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            const Divider(height: 0.05, color: ColorConst.dark),
            SizedBox(height: 16),
            Text(
              'Share this $type via',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: ShareContainer(FontAwesomeIcons.facebookF, context),
                ),
                InkWell(
                  onTap: shareToWhatsApp,
                  child: ShareContainer(FontAwesomeIcons.whatsapp, context),
                ),
                InkWell(
                  onTap: () {},
                  child: ShareContainer(FontAwesomeIcons.xTwitter, context),
                ),
                getW(context) > 460
                    ? InkWell(
                        onTap: () {},
                        child: ShareContainer(
                            FontAwesomeIcons.telegramPlane, context),
                      )
                    : Container(),
                getW(context) > 460
                    ? InkWell(
                        onTap: () {},
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Or',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorConst.dark, width: 0.5)),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.link,
                      size: 16,
                      color: ColorConst.primary,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: curationLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Link copied to clipboard!'),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      curationLink,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Logic to copy the link
                        Clipboard.setData(ClipboardData(text: curationLink));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Link copied to clipboard!'),
                          ),
                        );
                      },
                      child: Text(
                        'Copy',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.websiteHomeBox,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ); // Button color
  }
}

Widget ShareContainer(icon, context) {
  return Container(
    padding: EdgeInsets.all(16),
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
