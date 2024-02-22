import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  Page404({super.key});

  TextStyle normalTextStyle = TextStyle(
    fontSize: 45,
    color: ColorConst.primary,
    fontWeight: FontWeight.w700,
  );
  TextStyle italicBoldTextStyle = TextStyle(
      fontSize: 45,
      color: ColorConst.primary,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic);
  TextStyle italicTextStyle = TextStyle(
    fontSize: 45,
    color: ColorConst.primary,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.primaryBackground,
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/website/not_found.png",
                  width: 700,
                  height: 500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                width: 100,
                child: RichText(
                  textHeightBehavior: TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even),
                  textScaler: TextScaler.linear(1.1),
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Looks like\n", style: normalTextStyle),
                    TextSpan(text: "you've  ", style: italicTextStyle),
                    TextSpan(text: "ventured\n", style: normalTextStyle),
                    TextSpan(text: "into the\n", style: normalTextStyle),
                    TextSpan(
                        text: "Bermuda Triangle\n", style: italicBoldTextStyle),
                    TextSpan(text: "of the\n", style: normalTextStyle),
                    TextSpan(text: "INTERNET", style: normalTextStyle),
                  ]),
                ),
              ),
            )
          ]),
        ));
  }
}