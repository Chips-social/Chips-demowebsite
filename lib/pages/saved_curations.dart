import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:flutter/material.dart';

class SavedCurations extends StatelessWidget {
  const SavedCurations({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double screenWidth = getW(context);
    int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 950
            ? 3
            : screenWidth > 770
                ? 3
                : screenWidth < 700
                    ? 2
                    : 2;
    return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved",
              style: TextStyle(
                  fontSize: getW(context) * 0.018,
                  fontWeight: FontWeight.bold,
                  color: ColorConst.primary),
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
