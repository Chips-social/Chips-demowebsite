import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/utils/utils.dart';
import 'package:chips_demowebsite/widgets/menu_items.dart';
import 'package:chips_demowebsite/widgets/pin_widgets.dart';
import 'package:chips_demowebsite/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/widgets/pill_button.dart';

import '../widgets/my_snackbars.dart';

class Modal extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  Modal({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: ColorConst.chipBackground,
      surfaceTintColor: ColorConst.chipBackground,
      content: SizedBox(
          height: 530,
          width: 600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getW(context) < 500
                  ? Container()
                  : Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, -0.4),
                              end: Alignment(0.5, 1.0),
                              colors: [
                                Color.fromARGB(255, 201, 199, 206),
                                ColorConst.secondaryText
                              ],
                              stops: [0.012, 0.8833],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                            ),
                          ),
                          child: Image.asset(
                            'assets/website/login_model_card.png',
                            fit: BoxFit.cover,
                          ))),
              Expanded(
                  flex: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConst.chipBackground,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.02, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                    authController.isVerifyPage.value
                                        ? "Verify email"
                                        : 'Portal to Chips',
                                    style: TextStyle(
                                        color: ColorConst.primaryText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Image.asset('assets/icons/chips.png',
                                  height: 35, width: 35),
                            ],
                          ),

                          const SizedBox(height: 5),
                          Container(
                            width: 180,
                            child: Obx(
                              () => Text(
                                  authController.isLogIn.value
                                      ? "Before you start curating magic, tell us who you are"
                                      : authController.isVerifyPage.value
                                          ? "The guardians of the gateway need to confirm your entry."
                                          : 'Share the details and unlock the enchantment.',
                                  style: TextStyle(
                                      color: ColorConst.primaryGrey,
                                      fontSize: 12)),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          const Divider(
                            color: ColorConst.dividerLine,
                          ),
                          SizedBox(
                            height: getH(context) * 0.04,
                          ),
                          Obx(
                            () => authController.isVerifyPage.value
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Enter the verification code we just sent to your email Id ${authController.emailController.text}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Pinput(
                                          defaultPinTheme: defaultPinTheme,
                                          length: 6,
                                          animationDuration:
                                              Duration(milliseconds: 100),
                                          scrollPadding: EdgeInsets.all(5),
                                          submittedPinTheme: submittedPinTheme,
                                          validator: (code) {
                                            if (code!.length == 6 && authController.otpCode==code) {
                                              authController.verifyOtp();
                                              Get.offAllNamed('/');
                                            }
                                            else{
                                              return showErrorSnackBar(
                                                     heading: 'Error',
                                                     message: "Enter correct otp ",
                                                    icon: Icons.error,
                                                    color: Colors.redAccent);
                                            }
                                          },
                                          pinputAutovalidateMode:
                                              PinputAutovalidateMode.onSubmit,
                                          showCursor: true,
                                          onCompleted: (pin) => print(pin),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Didn't received code?   ",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                )),
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    // await resendVerificationCode(
                                                    //     "");
                                                  },
                                                  child: Text("Resend",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Color.fromRGBO(
                                                              173,
                                                              168,
                                                              245,
                                                              1.0),
                                                          decorationColor:
                                                              Color.fromRGBO(
                                                                  173,
                                                                  168,
                                                                  245,
                                                                  1.0),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline))),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      !authController.isLogIn.value
                                          ? MyTextField(
                                              obscureText: false,
                                              controller: authController
                                                  .userNameController,
                                              onChanged: (value) {},
                                              hintText: 'Username',
                                              errorText: 'null',
                                              keyboard: TextInputType.name,
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      !authController.isLogIn.value
                                          ? MyTextField(
                                              obscureText: false,
                                              controller:
                                                  authController.nameController,
                                              onChanged: (value) {},
                                              hintText: 'Full Name',
                                              errorText: 'null',
                                              keyboard: TextInputType.name,
                                            )
                                          : Container(),
                                      const SizedBox(height: 12),
                                      MyTextField(
                                        hintText: 'Email',
                                        controller:
                                            authController.emailController,
                                        onChanged: (value) {},
                                        obscureText: false,
                                        keyboard: TextInputType.emailAddress,
                                        errorText: 'null',
                                      ),
                                      const SizedBox(height: 12),
                                     /*  authController.isLogIn.value
                                          ? MyTextField(
                                              hintText: 'FullName',
                                              controller: authController
                                                  .passwordController,
                                              onChanged: (value) {},
                                              obscureText: true,
                                              keyboard:
                                                  TextInputType.visiblePassword,
                                              errorText: 'null',
                                            )
                                          : Container(), */
                                      const SizedBox(height: 15),
                                      Center(
                                        child: SizedBox(
                                          height: 40,
                                          width: 120,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (authController
                                                        .isLogIn.value ==
                                                    false) {
                                                  if (authController
                                                          .emailController
                                                          .text
                                                          .isEmpty ||
                                                      authController
                                                          .nameController
                                                          .text
                                                          .isEmpty ||
                                                      authController
                                                          .userNameController
                                                          .text
                                                          .isEmpty) {
                                                    return showErrorSnackBar(
                                                     heading: 'Error',
                                                     message: "Please Enter all fields",
                                                    icon: Icons.error,
                                                    color: Colors.redAccent);
                                                  }
                                                   var response = await authController
                                                     .registerUser();
                                                 if (response["success"]) {
                                                  authController
                                                      .toggleButtonLoad();
                                                  authController
                                                      .toggleVerifyPage();
                                                  // if (context.mounted)
                                                    // Navigator.pop(context);
                                                 } else {
                                                   showErrorSnackBar(
                                                       heading: 'Error',
                                                       message: response["message"],
                                                       icon: Icons.error,
                                                       color: Colors.redAccent);
                                                 }
                                                  
                                                }
                                                else{
                                                  if (authController
                                                          .emailController
                                                          .text
                                                          .isEmpty
                                                      ) {
                                                    return showErrorSnackBar(
                                                     heading: 'Error',
                                                     message: "Please Enter your Email",
                                                    icon: Icons.error,
                                                    color: Colors.redAccent);
                                                  }
                                                   var response = await authController
                                                     .authloginUser();
                                                 if (response["success"]) {
                                                  authController
                                                      .toggleButtonLoad();
                                                  authController
                                                      .toggleVerifyPage();
                                                }else {
                                                   showErrorSnackBar(
                                                       heading: 'Error',
                                                       message: response["message"],
                                                       icon: Icons.error,
                                                       color: Colors.redAccent);
                                                 }
                                                } 
                                              },
                                               
                                            
                                              style: ElevatedButton.styleFrom(
                                                  disabledBackgroundColor:
                                                      ColorConst.primaryGrey,
                                                  backgroundColor:
                                                      ColorConst.primary,
                                                  side: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1)),
                                              child: authController
                                                      .isButtonLoad.value
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Text(
                                                      authController
                                                              .isLogIn.value
                                                          ? "Login"
                                                          : 'Register',
                                                      style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          color: ColorConst
                                                              .buttonText,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    )),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Center(
                                          child: Text("or",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      SizedBox(height: 15),
                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero),
                                          onPressed: () {
                                            authController.signInWithGoogle();
                                          },
                                          child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            width: 180,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    20, 18, 24, 0.8),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  "assets/website/google_logo.png",
                                                  width: 30,
                                                ),
                                                Text(
                                                  "Sign in with google",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                          ),
                          Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      authController.isVerifyPage.value &&
                                              !authController.isLogIn.value
                                          ? "Entered Wrong email?  "
                                          : authController.isLogIn.value &&
                                                  authController
                                                      .isVerifyPage.value
                                              ? ""
                                              : !authController.isLogIn.value
                                                  ? "Already have an account?  "
                                                  : "Don't have a account?   ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      )),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                        onTap: () {
                                          if (authController
                                              .isVerifyPage.value) {
                                            authController.toggleVerifyPage();
                                            authController.toggleButtonLoad();
                                          } else {
                                            authController.toggleLogin();
                                          }
                                        },
                                        child: Text(
                                            authController.isVerifyPage.value &&
                                                    !authController
                                                        .isLogIn.value
                                                ? "Change"
                                                : authController
                                                            .isLogIn.value &&
                                                        authController
                                                            .isVerifyPage.value
                                                    ? ""
                                                    : !authController
                                                            .isLogIn.value
                                                        ? "Login"
                                                        : "Register ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    173, 168, 245, 1.0),
                                                decorationColor: Color.fromRGBO(
                                                    173, 168, 245, 1.0),
                                                decoration:
                                                    TextDecoration.underline))),
                                  ),
                                ],
                              ))
                        ],
                      )))
            ],
          )),
    );
  }
}
