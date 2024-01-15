import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';

class Modal extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Modal({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          content: Stack(
            children: [
               Container(
                    height: 300,
                    width: 650,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-1.0, -0.4),
                                    end: Alignment(0.5, 1.0),
                                    colors: [
                                      Color(0xFF5434F4),
                                      Color(0xFF7D3FF3)
                                    ],
                                    stops: [0.012, 0.8833],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    bottomLeft: Radius.circular(32),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Image.asset(
                                        'assets/website/login_model_card.png',
                                        height: 270,
                                        width: 330)
                                  ],
                                ))),
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 300,
                                decoration: const BoxDecoration(
                                  color: ColorConst.chipBackground,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(32),
                                    bottomRight: Radius.circular(32),
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text('Just a minute',
                                                    style: TextStyle(
                                                        color: ColorConst
                                                            .primaryText,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Image.asset(
                                                      'assets/icons/chips.png',
                                                      height: 40,
                                                      width: 40))
                                            ]),
                                        const SizedBox(height: 10),
                                        const Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  'Before you start curating magic,tell us who you are',
                                                  style: TextStyle(
                                                      color: ColorConst
                                                          .primaryGrey,
                                                      fontSize: 12)),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: SizedBox(
                                                  width: 150,
                                                ))
                                          ],
                                        ),
                                       // const SizedBox(height: 5),
                                        const Divider(
                                          color: ColorConst.dividerLine,
                                        ),
                                         /* MyTextField(
                                          obscureText: false,
                                          controller: nameController,
                                          onChanged:() async{},
                                          hintText: 'name',
                                        ), */
                                        TextField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primary, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
                                          ),
                                          hintText: 'name',
                                          hintStyle: TextStyle(color:ColorConst.primaryGrey),
                                            ),
                                          style: TextStyle(color: ColorConst.subscriptionSubtext),
                                          ),
                                          const SizedBox(height:4),
                                          TextField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primary, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:
                                                const BorderSide(color: ColorConst.primaryGrey, width: 1.0),
                                          ),
                                          
                                          hintText: 'email address',
                                           hintStyle: TextStyle(color:ColorConst.primaryGrey),
                                            ),
                                           style: TextStyle(color: ColorConst.subscriptionSubtext)
                                          ),
                                          const SizedBox(height:8),
                                          PillButton(
                                            onTap: () async {},
                                            text: 'Start curating', 
                                            textColor: ColorConst.buttonText,
                                            height: 30,) 
                                      ],
                                    ))))
                      ],
                    )) 
            ],
          ),
        );
  }
}
