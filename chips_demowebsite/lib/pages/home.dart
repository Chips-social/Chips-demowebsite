import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryBackground,
      body:Padding(
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
                child:  Image.asset(
                    'assets/icons/logo.png',
                    height:100,
                    width:100
                  ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width:600,
                  child:TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: ColorConst.dark,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: ColorConst.textFieldColor,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorConst.textFieldColor,
                      ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                )
                )
              ),
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
          DefaultTabController(
                  length: 7,
                  //isScrollable: true,
                  child: Column(
                    children: [
                      TabBar(
                    tabs: [
                      Tab(
                        text: 'Food & Drinks'
                      ),
                      Tab(
                        text: 'Entertainment'
                      ),
                      Tab(
                        text: 'Science & Tech'
                      ),
                      Tab(
                        text: 'Art & Design'
                      ),
                      Tab(
                        text: 'Interiors & Lifestyle'
                      ),
                      Tab(
                        text: 'Travel'
                      ),
                      Tab(
                        text: 'Fashion & Beauty'
                      ),                     
                  ],
                  ),
                      ]
                    )
                  ),
        ]
      )
      )   
    );
  }
}