import 'package:chips_demowebsite/business/home_sidebar.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/data/data.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/pages/sidebar.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key, required this.child});
  final Widget child;

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    bool isNarrowScreen = MediaQuery.of(context).size.width <= 600;
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConst.primaryBackground,
            appBar: AppBar(
              automaticallyImplyLeading: isNarrowScreen ? true : false,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              toolbarHeight: 85,
              leadingWidth: getW(context) > 400 ? 70 : 0,
              elevation: 0,
              title: NavBar(context),
            ),
            drawer: isNarrowScreen ? SideBar() : null,
            onDrawerChanged: (isOpen) {
              homeController.drawerOpen.value = isOpen;
            },
            body: Padding(
              padding: EdgeInsets.only(right: getW(context) * 0.025),
              child: Stack(
                children: [
                  Positioned(
                    top: 14,
                    bottom: 0,
                    left: getW(context) > 600 ? 200 : 0,
                    right: 0,
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => homeController.drawerOpen.value
                ? Container()
                : Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: getW(context) < 400
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: 20, left: getW(context) < 400 ? 70 : 0),
                            width: getW(context) < 450
                                ? getW(context) * 0.5
                                : getW(context) < 600
                                    ? getW(context) * 0.5
                                    : getW(context) * 0.4,
                            child: Obx(
                              () => TextField(
                                style: const TextStyle(color: Colors.white),
                                controller:
                                    homeController.globalSearchController,
                                // textAlign:
                                //     homeController.globalSearchController.text.isEmpty
                                //         ? TextAlign.center
                                //         : TextAlign.start,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorConst.dark,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                    color: ColorConst.textFieldColor,
                                  ),
                                  prefixIcon: Padding(
                                    padding: homeController
                                            .globalSearchController.text.isEmpty
                                        ? EdgeInsets.only(
                                            left: getW(context) < 450
                                                ? getW(context) * 0.1
                                                : getW(context) < 600
                                                    ? getW(context) * 0.18
                                                    : getW(context) * 0.14,
                                            right: 10)
                                        : EdgeInsets.zero,
                                    child: const Icon(
                                      Icons.search,
                                      color: ColorConst.textFieldColor,
                                    ),
                                  ),
                                  suffixIcon: homeController
                                          .globalSearchController
                                          .text
                                          .isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            homeController
                                                .globalSearchController
                                                .clear();
                                            homeController
                                                .searchSuggestions.value = [];
                                          },
                                          child: const Icon(Icons.close,
                                              color: ColorConst.textFieldColor),
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: Radius.circular(
                                            homeController
                                                    .searchSuggestions.isEmpty
                                                ? 10
                                                : 0),
                                        bottomRight: Radius.circular(
                                            homeController
                                                    .searchSuggestions.isEmpty
                                                ? 10
                                                : 0)),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onChanged:
                                    homeController.fetchSearchSuggestions,
                              ),
                            )),
                        Obx(
                          () => homeController.searchSuggestions.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: 0.3,
                                      left: getW(context) < 400 ? 70 : 0),
                                  padding: EdgeInsets.only(
                                      top: 10,
                                      left: getW(context) < 450 ? 3 : 10),
                                  height:
                                      homeController.searchSuggestions.length ==
                                              1
                                          ? 80
                                          : homeController.searchSuggestions
                                                      .length ==
                                                  2
                                              ? 180
                                              : 250,
                                  width: getW(context) < 600
                                      ? getW(context) * 0.5
                                      : getW(context) < 450
                                          ? getW(context) * 0.6
                                          : getW(context) * 0.4,
                                  color: ColorConst.dark,
                                  child: ListView.builder(
                                    itemCount:
                                        homeController.searchSuggestions.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: ListTile(
                                              onTap: () {
                                                String categoryName =
                                                    Uri.encodeComponent(
                                                        homeController
                                                                .searchSuggestions[
                                                            index]['category']);
                                                String curationName =
                                                    Uri.encodeComponent(
                                                        homeController
                                                                .searchSuggestions[
                                                            index]['name']);
                                                String gotourl =
                                                    '/category/$categoryName/curation/$curationName/id/${homeController.searchSuggestions[index]['_id']}';

                                                homeController
                                                    .globalSearchController
                                                    .clear();
                                                homeController.searchSuggestions
                                                    .value = [];
                                                GoRouter.of(context)
                                                    .go(gotourl);
                                              },
                                              dense: true,
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  homeController.CurationImages[
                                                      homeController.categories
                                                          .indexOf(homeController
                                                                  .searchSuggestions[
                                                              index]['category'])],
                                                  fit: BoxFit.fitHeight,
                                                  height: 70,
                                                  width: 60,
                                                ),
                                              ),
                                              title: Text(
                                                homeController
                                                        .searchSuggestions[
                                                    index]['name'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        getW(context) < 450
                                                            ? 12
                                                            : 14),
                                              ),
                                              subtitle: Text(
                                                homeController
                                                        .searchSuggestions[
                                                    index]['user_id']['name'],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        getW(context) < 450
                                                            ? 10
                                                            : 12),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: ColorConst.dividerLine
                                                .withOpacity(0.4),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
          ),
          getW(context) > 600
              ? Positioned(top: 100, bottom: 0, left: 0, child: HomeSidebar())
              : Container(),
        ],
      ),
    );
  }
}
