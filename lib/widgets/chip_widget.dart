import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/like_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/youtube_chip.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/widgets/share_modal.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ChipWidget extends StatelessWidget {
  final String chipId;
  final String name;
  final DateTime timeAdded;
  final String text;
  final String date;
  final String url;
  final List imageURLS;
  final List isSavedList;
  final String locationUrl;
  final String linkUrl;
  final List likes;

  ChipWidget({
    super.key,
    this.chipId = 'null',
    required this.text,
    required this.imageURLS,
    this.date = '',
    required this.isSavedList,
    this.url = '',
    this.locationUrl = '',
    this.linkUrl = '',
    required this.name,
    required this.timeAdded,
    required this.likes,
/*     this.likeCount= 100,
    this.commentCount= 20,
    this.savedBy=0,
    this.sharedBy=0 */
  });

  final ChipController chipController = Get.put(ChipController());
  final AuthController authController = Get.find<AuthController>();
  final LikeController likeController = Get.put(LikeController());
  final SidebarController sidebarController = Get.find<SidebarController>();

  @override
  Widget build(BuildContext context) {
    String urlType = identifyPlatform(linkUrl);

    likeController.checkLikedStatus(likes, authController.userId.value);

    return Card(
      color: ColorConst.chipBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Initicon(
                      text: name,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getW(context) > 600 ? 120 : 100,
                          child: AutoSizeText(
                            name,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          timeago.format(timeAdded, allowFromNow: false),
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'Inter',
                            fontSize: getW(context) > 760 ? 13 : 11,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    chipController.isCreatingChip.value = false;
                    chipController.selectedChipId.value = chipId;
                    await sidebarController.myCurations();
                    await sidebarController.mySavedCurations();
                    saveChip(context);
                  },
                  child: SvgPicture.asset(
                    isSavedList.contains(authController.currentUser['_id'])
                        ? 'assets/icons/bookmark_selected_state.svg'
                        : 'assets/icons/bookmark_empty.svg',
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Text Widget
          text == "null"
              ? const SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
                  child: Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

          //Date/Time/Url

          date == ""
              ? const SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.white54,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          date,
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        ),
                                      ),
                                    ],
                                  )),
                              // Expanded(
                              //     flex: 1,
                              //     child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         const Icon(
                              //           Icons.access_time_outlined,
                              //           color: Colors.white54,
                              //           size: 18,
                              //         ),
                              //         const SizedBox(width: 10),
                              //         Flexible(
                              //           child: Text(
                              //             time,
                              //             style: const TextStyle(
                              //                 color: Colors.white54),
                              //           ),
                              //         )
                              //       ],
                              //     )),
                            ]),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(Uri.parse(locationUrl)))
                              throw 'Could not launch';
                          },
                          child: Row(children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white54,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                url,
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 13),
                              ),
                            )
                          ]),
                        ),
                        const SizedBox(height: 5)
                      ]),
                ),

          const SizedBox(height: 10),
          // Image Widget
          imageURLS.isEmpty
              ? const SizedBox()
              : imageURLS.length == 1
                  ? Center(
                      child: Container(
                      height: 190,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imageURLS[0],
                            fit: BoxFit.cover,
                          )),
                    ))
                  : MouseRegion(
                      cursor: SystemMouseCursors.grabbing,
                      child: Container(
                        height: 190,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: imageURLS.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 16),
                                height: 190,
                                width: 190,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                        image: NetworkImage(imageURLS[index]),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ),
                    ),

          linkUrl == ""
              ? const SizedBox()
              : urlType == "YouTube"
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.013, vertical: 10),
                      child: YoutubeChip(youtubeURL: linkUrl),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.01),
                      child: NestedChip(url: linkUrl),
                    ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        var chip = await likeController.setChipId(chipId);
                        if (chip.isNotEmpty) {
                          await likeController.likeUnlikeChip();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Row(children: [
                          SvgPicture.asset(
                            likes.contains(authController.currentUser['_id'])
                                ? 'assets/icons/liked.svg' // Liked icon
                                : 'assets/icons/like.svg',
                            /* authController.userId != 'null' && likes.contains(authController.userId)
                                ? 'assets/icons/liked.svg' // Liked icon
                                : 'assets/icons/like.svg', */
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            likes.length.toString(),
                            // likeCount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ]),
                      )),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        showErrorSnackBar(
                            heading: "Coming Soon",
                            message: "You will soon see this feature.",
                            icon: Icons.share,
                            color: Colors.white);
                        // showShareDialog(context, "scscs", "chip");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 1),
                        height: 50,
                        width: 50,
                        child: Row(children: [
                          SvgPicture.asset(
                            'assets/icons/share_icon.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '',
                            // likeCount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                          const Spacer(),
                        ]),
                      )),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        showErrorSnackBar(
                            heading: "Coming Soon",
                            message: "You will soon see this feature.",
                            icon: Icons.share,
                            color: Colors.white);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/down_arrow.svg',
                        ),
                      )),
                ]),
          ),
          SizedBox(height: 10),
        ],
      ),
      // )
    );
  }
}
