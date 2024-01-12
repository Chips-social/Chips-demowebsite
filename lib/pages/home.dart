import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/widgets/tab_widget.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.primaryBackground,
        body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const SizedBox(height:5),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/icons/logo.png',
                            height: 100, width: 100),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 600,
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorConst.dark,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                    color: ColorConst.textFieldColor,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: ColorConst.textFieldColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: PillButton(
                          onTap: () async {},
                          text: 'Login or Sign up',
                          textColor: ColorConst.buttonText,
                          backGroundColor: ColorConst.primary,
                          borderColor: ColorConst.primary,
                          width: 160,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height - 120,
                            color: Colors.amber,
                          )),
                      Expanded(
                          flex: 6,
                          child: Container(
                            height: MediaQuery.of(context).size.height - 120,
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // #Home
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        child: TabBar(
                                            controller:
                                                homeController.tabController,
                                            isScrollable: false,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            labelColor: ColorConst.primary,
                                            indicatorColor: ColorConst.primary,
                                            tabs: const [
                                              Tab(text: 'Food & Drinks'),
                                              Tab(text: 'Entertainment'),
                                              Tab(text: 'Science & Tech'),
                                              Tab(text: 'Art & Design'),
                                              Tab(
                                                  text:
                                                      'Interiors & Lifestyle'),
                                              Tab(text: 'Travel'),
                                              Tab(text: 'Fashion & Beauty'),
                                            ]),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.navigate_next_rounded,
                                        color: ColorConst.primary,
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: TabBarView(
                                  controller: homeController.tabController,
                                  children: [
                                    TabWidget(title: 'Food & Drinks'),
                                    TabWidget(title: 'Entertainment'),
                                    TabWidget(title: 'Science & Tech'),
                                    TabWidget(title: 'Art & Design'),
                                    TabWidget(title: 'Interiors & Lifestyle'),
                                    TabWidget(title: 'Travel'),
                                    TabWidget(title: 'Fashion & Beauty'),
                                  ],
                                ))
                              ],
                            ),
                          )),
                    ],
                  ),
                ])));
  }
}

/* Widget getTabWidget({required String title}) {
  return Container(
    
    child: Text(
    title,
    style: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: ColorConst.primary),
  ));
} */
