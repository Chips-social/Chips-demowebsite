import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BusinessHomeCuration extends StatefulWidget {
  const BusinessHomeCuration({super.key});

  @override
  State<BusinessHomeCuration> createState() => _BusinessHomeCurationState();
}

class _BusinessHomeCurationState extends State<BusinessHomeCuration> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = getW(context);

    int crossAxisCount = screenWidth > 1200
        ? 5
        : screenWidth > 950
            ? 4
            : screenWidth > 770
                ? 3
                : screenWidth > 360
                    ? 2
                    : 1;
    return Padding(
        padding: EdgeInsets.only(left: getW(context) < 400 ? 15 : 25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFF4F4C58), width: 0.6),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/website/whats_app.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConst.dark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Text("Unsubscribe",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: ColorConst.primary,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(children: [
                    Icon(
                      Icons.link,
                      color: ColorConst.primary,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "https://wework.co.in/labs/",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: ColorConst.primary,
                            fontSize: 13),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "WeWork Labs aims to streamline the early-stage for both founders and investors. Through our varied offerings, we systematically eliminate barriers to growth, so that founders can focus on building sustainable, valuable companies of the future.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 28,
                  crossAxisCount: crossAxisCount,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {},
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        color: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Image.asset(
                                    "assets/website/food_drinks.png",
                                    fit: BoxFit.cover,
                                    height: 150, // Adjust the height
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, top: 5),
                              child: Text(
                                "name", // Replace with your item title
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 5),
                            //       child: Text(
                            //                 "Chips.Social",
                            //         style: const TextStyle(
                            //             fontSize: 13, color: Colors.grey),
                            //       ),
                            //     ),
                            //     const Padding(
                            //       padding: EdgeInsets.only(right: 5),
                            //       child: Text(
                            //         '', // Replace with your chips count
                            //         style: TextStyle(
                            //             fontSize: 12, color: Colors.grey),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
