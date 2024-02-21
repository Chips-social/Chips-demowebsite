import '../constants/color_constants.dart';
import 'package:flutter/material.dart';

class NestedChip extends StatelessWidget {
  final String title;
  final String text;
  final String imageURL;

  const NestedChip(
      {super.key,
      required this.title,
      required this.text,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate the user
      },
      child: Card(
        margin: EdgeInsets.only(top: 10),
        color: ColorConst.dark,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.lightBlueAccent, fontSize: 16)),
              Text(text, style: const TextStyle(color: ColorConst.primaryText)),
              const SizedBox(height: 10),
              Container(
                height: 140,
                width: 250,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
