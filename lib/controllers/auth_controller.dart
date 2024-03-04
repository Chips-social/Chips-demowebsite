import 'package:chips_demowebsite/constants/color_constants.dart';
import 'package:chips_demowebsite/main.dart';
import 'package:chips_demowebsite/pages/navbar.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final box = GetStorage("chips_user");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  RxBool isLogIn = false.obs;
  RxBool isVerifyPage = false.obs;
  RxBool isButtonLoad = false.obs;
  var otpCode = "".obs;

  var currentUser = {};
  var userId = ''.obs;
  var authToken = Rx<String?>(null);

  final isLoggedIn = false.obs;
  // bool get isAuthenticated => box.read('is_authenticated') ?? false;

  @override
  void onInit() {
    super.onInit();
    String? token = getAuthToken();
    authToken.value = token;
    isLoggedIn.value = token != null;
  }

  void toggleLogin() {
    isLogIn.value = !isLogIn.value;
  }

  void toggleVerifyPage() {
    isVerifyPage.value = !isVerifyPage.value;
  }

  void toggleButtonLoad() {
    isButtonLoad.value = !isButtonLoad.value;
  }

  Future<bool> saveAuthToken(String? token) async {
    await box.write('auth_token', token);
    authToken.value = token;
    isLoggedIn.value = true;
    return true;
  }

  String? getAuthToken() {
    return box.read('auth_token');
  }

  Future<bool> deleteAuth() async {
    await box.remove('auth_token');
    return true;
  }

  // Future<bool> loginUser() async {
  //   await box.write('is_authenticated', true);
  //   return true;
  // }

  Future<bool> logoutUser() async {
    await googleSignIn.signOut();
    await box.remove('is_authenticated');
    await box.remove('user_data');
    isLoggedIn.value = false;
    await deleteAuth();
    isLogIn.value = false;
    isVerifyPage.value = false;
    isButtonLoad.value = false;
    Get.offAllNamed('/category/${Uri.encodeComponent("Food & Drinks")}');
    return true;
  }

  setCurrentUser(data) async {
    await box.write('user_data', data);
    currentUser = Map.from(data);
  }

  getCurrentUser() {
    return box.read('user_data') ?? {};
  }

  registerUser() async {
    var data = {
      "email": emailController.text,
      "name": nameController.text,
      "username": userNameController.text
    };
    var response =
        await postRequestUnAuthenticated(endpoint: '/register', data: data);
    if (response["success"]) {
      var otp = response["otp"];
      otpCode.value = otp.toString();

      return {"success": true, "message": "Email verfication send"};
    } else {
      isLoggedIn.value = false;
      return {"success": false, "message": response["message"]};
    }
  }

  authloginUser() async {
    var data = {"email": emailController.text};
    var response =
        await postRequestUnAuthenticated(endpoint: '/login', data: data);
    if (response["success"]) {
      var otp = response["otp"];
      otpCode.value = otp.toString();

      return {"success": true, "message": "Email verification send "};
    } else {
      isLoggedIn.value = false;
      return {"success": false, "message": response["message"]};
    }
  }

  verifyOtp() async {
    try {
      var data = {
        "email": emailController.text,
        "name": nameController.text,
        "username": userNameController.text
      };
      var response = await postRequestUnAuthenticated(
          endpoint: '/verify/auth', data: data);
      if (response["success"]) {
        isLoggedIn.value = true;
        saveAuthToken(response['auth_token']);
        setCurrentUser(response['user']);
        userId.value = response['user']['_id'];
        Get.offAllNamed('/category/${Uri.encodeComponent("Food & Drinks")}');
        showErrorSnackBar(
            heading: 'Success',
            message: response["message"],
            icon: Icons.check_circle,
            color: ColorConst.success);
        return {"success": true, "message": "Auth Successful"};
      } else {
        isLoggedIn.value = false;
        return {"success": false, "message": response["message"]};
      }
    } catch (e) {
      print("Failed to signin : $e");
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        print("Signed in with Google: ${account.email}");

        final GoogleSignInAuthentication? googleAuth =
            await account.authentication;

        var data = {"email": account.email, "name": account.displayName};
        var response =
            await postRequestUnAuthenticated(endpoint: '/auth', data: data);
        if (response["success"]) {
          isLoggedIn.value = true;
          saveAuthToken(response['auth_token']);
          setCurrentUser(response['user']);
          userId.value = response['user']['_id'];
          print(userId.value);
          Get.offAllNamed('/category/${Uri.encodeComponent("Food & Drinks")}');

          showErrorSnackBar(
              heading: 'Success',
              message: response["message"],
              icon: Icons.check_circle,
              color: ColorConst.success);
          return {"success": true, "message": "Auth Successful"};
        } else {
          isLoggedIn.value = false;
          return {"success": false, "message": response["message"]};
        }
      }
    } catch (error) {
      print("Failed to sign in with Google: $error");
    }
  }
}
