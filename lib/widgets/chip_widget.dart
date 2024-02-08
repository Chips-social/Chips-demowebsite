import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/pages/youtube_chip.dart';
import 'package:chips_demowebsite/widgets/nested_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChipWidget extends StatelessWidget {
  final String name;
  final DateTime timeAdded;
  final String text;
  final bool dateTimeUrl;
  final String date;
  final String time;
  final String url;
  final List imageURLS;
  final bool showRSVP;
  final bool showNestedCard;
  final String nestedText;
  final String nestedTitle;
  final String nestedImageURL;
  final bool showYoutube;
  final String youtubeURL;
/*   final int likeCount;
  final int commentCount;
  final int sharedBy;
  final int savedBy; */

  const ChipWidget({
    super.key,
    required this.text,
    required this.dateTimeUrl,
    required this.imageURLS,
    required this.showRSVP,
    required this.showNestedCard,
    this.date = '',
    this.time = '',
    this.url = '',
    this.nestedTitle = '',
    this.nestedText = '',
    this.nestedImageURL = '',
    required this.showYoutube,
    this.youtubeURL = 'null',
    required this.name,
    required this.timeAdded,
/*     this.likeCount= 100,
    this.commentCount= 20,
    this.savedBy=0,
    this.sharedBy=0 */
  });

  @override
  Widget build(BuildContext context) {
    // final ChipWidgetController chipWidgetController = Get.put(ChipWidgetController());

    return Container(
        width: 300,
        child: Card(
            color: ColorConst.chipBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Initicon(
                              text: name,
                              elevation: 4,
                              borderRadius: BorderRadius.circular(14),
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                            )
                            // Icon(
                            //   Icons.person,
                            //   size: 40,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              timeago.format(timeAdded, allowFromNow: false),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/bookmark_empty.svg',
                              width: 32,
                              height: 32,
                            )
                        ],)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Text Widget
                  text == "null"
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Text(
                            text,
                            //textAlign: TextAlign.justify,
                            style: const TextStyle(color: Colors.white),
                          )),

                  //Date/Time/Url
                  dateTimeUrl == false
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.access_time_outlined,
                                                color: Colors.white54,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  time,
                                                  style: const TextStyle(
                                                      color: Colors.white54),
                                                ),
                                              )
                                            ],
                                          )),
                                    ]),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(children: [
                                    const Icon(
                                      Icons.link,
                                      color: Colors.white54,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        url,
                                        style: const TextStyle(
                                            color: Colors.white54),
                                      ),
                                    )
                                  ]),
                                ),
                                const SizedBox(height: 10)
                              ]),
                        ),

                  //const SizedBox(height: 10),

                  // Image Widget
                  imageURLS.isEmpty
                      ? const SizedBox()
                      : imageURLS.length == 1
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child:Container(
                                        height: 200,
                                         decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      imageURLS[0],
                                                      fit: BoxFit.cover,
                                                    )),
                                        //child: Image.network(imageURLS[0]),
                                    ),
                                      )
                                     
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageURLS.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      imageURLS[index],
                                                      fit: BoxFit.cover,
                                                    )),
                                              ));
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              )),

                  showNestedCard == false
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: NestedChip(
                            title: nestedTitle,
                            text: nestedText,
                            imageURL: nestedImageURL,
                          )),

                  showYoutube == false
                      ? const SizedBox()
                      : YoutubeChip(youtubeURL: youtubeURL),
                  //const SizedBox(height: 20),
                 Padding(
                  padding:EdgeInsets.only(left:20, right:20),
                   child: Row( 
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                    GestureDetector(
                      onTap: () {
                          // Handle favorite icon tap
                      },
                      child:Container(
                        height:50,
                        width:50,
                        child: Row(
                          children:[
                            SvgPicture.asset(
                                'assets/icons/like.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width:4),
                          Text(
                          '3k',
                         // likeCount.toString(),
                           style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white54,
                          ),
                        ),
                        const Spacer(),
                        ]
                        ),
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                          // Handle favorite icon tap
                      },
                      child:Container(
                        height:50,
                        width:50,
                        child: Row(
                          children:[
                            SvgPicture.asset(
                                'assets/icons/share_icon.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width:4),
                          Text(
                          '2k',
                         // likeCount.toString(),
                           style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white54,
                          ),
                        ),
                        const Spacer(),
                        ]
                        ),
                      )
                    ),
                    const SizedBox(width:4),
                    GestureDetector(
                      onTap: () {
                          // Handle favorite icon tap
                      },
                      child:Container(
                        height:50,
                        width:50,
                        child: Row(
                          children:[
                            SvgPicture.asset(
                                'assets/icons/down_arrow.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width:4),
                        ]
                        ),
                      )
                    ),

                    ]
                    ),
                 ),
                 const SizedBox(height:10), 
                ],
              ),
            )));
  }
}
