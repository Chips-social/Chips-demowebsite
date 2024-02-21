import 'package:chips_demowebsite/main.dart';
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
  final TextEditingController codeController = TextEditingController();

  RxBool isLogIn = false.obs;
  RxBool isVerifyPage = false.obs;
  RxBool isButtonLoad = false.obs;

  var currentUser = {};
  var userId = ''.obs;

  final isLoggedIn = true.obs;
  bool get isAuthenticated => box.read('is_authenticated') ?? false;

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
    return true;
  }

  String? getAuthToken() {
    return box.read('auth_token');
  }

  Future<bool> deleteAuth() async {
    await box.write('auth_token', null);
    return true;
  }

  Future<bool> loginUser() async {
    await box.write('is_authenticated', true);
    return true;
  }

  Future<bool> logoutUser() async {
    await box.write('is_authenticated', false);
    await box.write('user_data', null);
    await deleteAuth();
    return true;
  }

  setCurrentUser(data) async {
    await box.write('user_data', data);
    currentUser = Map.from(data);
  }

  getCurrentUser() {
    return box.read('user_data') ?? {};
  }

  //Create a function which sends a POST request with email and name to the end point
  authenticateUser() async {
    var data = {"email": emailController.text, "name": nameController.text};
    var response =
        await postRequestUnAuthenticated(endpoint: '/auth', data: data);
    if (response["success"]) {
      isLoggedIn.value = true;
      saveAuthToken(response['auth_token']);
      setCurrentUser(response['user']);
      userId.value = response['user']['_id'];
      print(userId.value);
      return {"success": true, "message": "Auth Successful"};
    } else {
      isLoggedIn.value = false;
      return {"success": false, "message": response["message"]};
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        print("Signed in with Google: ${account.email}");

        // Optionally, retrieve the authentication token:
        final GoogleSignInAuthentication? googleAuth =
            await account.authentication;
        final accessToken = googleAuth?.accessToken;
        final idToken = googleAuth?.idToken;
        sendTokenToServer(idToken.toString());
        auth.isLoggedIn.value = true;
        Get.offAllNamed('/');
      }
    } catch (error) {
      print("Failed to sign in with Google: $error");
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User signed out from Google");
  }
}
