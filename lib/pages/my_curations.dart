import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCurations extends StatelessWidget {
  MyCurations({
    super.key,
  });
  String title = Get.parameters['title'] ?? 'abcde';
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
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: screenWidth < 360 ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConst.primary),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(127, 62, 255, 60),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: TextButton(
                      onPressed: () {
                        // curationController.saveCuration();
                      },
                      child: const Row(
                        children: [
                          Text('+ New Curation',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 10,
                    crossAxisCount: crossAxisCount,
                  ),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   '/details',
                          //   arguments: {
                          //     'chipsList': widget.chipsList,
                          //     'filteredList': filteredList,
                          //     'title': widget.title,
                          //   },
                          // );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          color: Colors.transparent,
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 1, color: Colors.grey)),
                                    child: Image.network(
                                      'assets/website/curation_image.png', // Replace with your image URL
                                      fit: BoxFit.cover,
                                      height: 150, // Adjust the height
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5),
                                child: Text(
                                  'Item $index', // Replace with your item title
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Subtitle', // Replace with your item subtitle
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '31 Chips', // Replace with your chips count
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
