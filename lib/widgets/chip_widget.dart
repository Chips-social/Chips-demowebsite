import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/like_controller.dart';
import 'package:chips_demowebsite/controllers/sidebar_controller.dart';
import 'package:chips_demowebsite/pages/create_chip_modal.dart';
import 'package:chips_demowebsite/pages/youtube_chip.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:chips_demowebsite/widgets/home_start_card.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ChipWidget extends StatefulWidget {
  final String chipId;
  final String curId;
  final String name;
  final String userId;
  final DateTime timeAdded;
  final String text;
  final String date;
  final String url;
  final List imageURLS;
  final List isSavedList;
  final String locationUrl;
  final String linkUrl;
  final List likes;

  const ChipWidget({
    super.key,
    this.chipId = 'null',
    this.userId = "",
    this.curId = '',
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

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  final ChipController chipController = Get.put(ChipController());

  final AuthController authController = Get.find<AuthController>();

  final LikeController likeController = Get.put(LikeController());

  final SidebarController sidebarController = Get.find<SidebarController>();

  bool isLiked = false;
  int likeCount = 0;
  // bool isSaved = false;

  @override
  void initState() {
    super.initState();
    isLiked = authController.isLoggedIn.value &&
        widget.likes.contains(authController.currentUser['_id']);
    likeCount = widget.likes.length;
    chipController.isChipSaved.value = authController.isLoggedIn.value &&
        widget.isSavedList.contains(authController.currentUser['_id']);
  }

  @override
  Widget build(BuildContext context) {
    String urlType = identifyPlatform(widget.linkUrl);

    likeController.checkLikedStatus(widget.likes, authController.userId.value);

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
                      text: widget.name,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getW(context) > 600 ? 120 : 100,
                          child: AutoSizeText(
                            widget.name,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          timeago.format(widget.timeAdded, allowFromNow: false),
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
                Obx(
                  () => InkWell(
                    onTap: () async {
                      if (authController.isLoggedIn.value) {
                        chipController.isCreatingChip.value = false;
                        chipController.selectedChipId.value = widget.chipId;
                        chipController.selectedCurationId.value = widget.curId;

                        if (chipController.isChipSaved.value) {
                          await chipController.unsaveChip(widget.curId);
                          chipController.isChipSaved.value = false;

                          showErrorSnackBar(
                              heading: "Chip",
                              message: "Unsaved chip",
                              icon: Icons.save,
                              color: Colors.white);
                        } else {
                          await sidebarController.myCurations();
                          await sidebarController.mySavedCurations();
                          saveChip(context);
                        }
                      } else {
                        showLoginDialog(context);
                      }
                    },
                    child: SvgPicture.asset(
                      chipController.isChipSaved.value
                          ? 'icons/bookmark_selected_state.svg'
                          : 'assets/icons/bookmark_empty.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Text Widget
          widget.text == "null"
              ? const SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

          //Date/Time/Url

          widget.date == ""
              ? const SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
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
                                          widget.date,
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
                        widget.url != ""
                            ? GestureDetector(
                                onTap: () async {
                                  if (!await launchUrl(
                                      Uri.parse(widget.locationUrl))) {
                                    throw 'Could not launch';
                                  }
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
                                      widget.url,
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 13),
                                    ),
                                  )
                                ]),
                              )
                            : Container(),
                        const SizedBox(height: 5)
                      ]),
                ),

          const SizedBox(height: 10),
          // Image Widget
          widget.imageURLS.isEmpty
              ? const SizedBox()
              : widget.imageURLS.length == 1
                  ? Center(
                      child: Container(
                      height: 190,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                              image: NetworkImage(widget.imageURLS[0]),
                              fit: BoxFit.cover)),
                    ))
                  : MouseRegion(
                      cursor: SystemMouseCursors.grabbing,
                      child: SizedBox(
                        height: 190,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.imageURLS.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(left: 16),
                                height: 190,
                                width: 190,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                        image: NetworkImage(
                                            widget.imageURLS[index]),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ),
                    ),

          widget.linkUrl == ''
              ? const SizedBox()
              : urlType == "YouTube"
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.013, vertical: 10),
                      child: YoutubeChip(youtubeURL: widget.linkUrl),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.01),
                      child: NestedChip(url: widget.linkUrl),
                    ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.013),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        if (authController.isLoggedIn.value) {
                          var chip = likeController.setChipId(widget.chipId);
                          if (chip.isNotEmpty) {
                            setState(() {
                              isLiked = !isLiked;
                              isLiked ? likeCount++ : likeCount--;
                            });
                            await likeController.likeUnlikeChip();
                          }
                        } else {
                          showLoginDialog(context);
                        }
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Row(children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: SvgPicture.asset(
                              isLiked
                                  ? 'assets/icons/liked.svg'
                                  : 'assets/icons/like.svg',
                              key: ValueKey<bool>(isLiked),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            likeCount.toString(),
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
                        margin: const EdgeInsets.only(top: 1),
                        height: 50,
                        width: 50,
                        child: Row(children: [
                          SvgPicture.asset(
                            'assets/icons/share_icon.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '',
                            // likeCount.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                          const Spacer(),
                        ]),
                      )),
                  const Spacer(),
                  InkWell(
                      onTap: () {},
                      child: PopupMenuButton(
                        position: PopupMenuPosition.under,
                        padding: const EdgeInsets.all(5),
                        color: ColorConst.dark,
                        onSelected: (String result) {
                          switch (result) {
                            case 'Delete':
                              chipController.selectedChipId.value =
                                  widget.chipId;
                              if (widget.userId ==
                                  authController.currentUser['_id']) {
                                choiceModal(
                                    context,
                                    "Are you sure you want to delete this chip? Once it is deleted, you won`t be able to retrieve it back.",
                                    "Chip");
                              } else {
                                showErrorSnackBar(
                                    heading: "User",
                                    message:
                                        "You are not the owner of this chip.",
                                    icon: Icons.featured_play_list,
                                    color: Colors.white);
                              }
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Delete',
                            child: Text(
                              'Delete',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.userId ==
                                          authController.currentUser['_id']
                                      ? ColorConst.primary
                                      : Colors.grey),
                            ),
                          ),
                        ],
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/icons/down_arrow.svg',
                          ),
                        ),
                      )),
                ]),
          ),
          const SizedBox(height: 10),
        ],
      ),
      // )
    );
  }
}
