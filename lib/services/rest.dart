import 'dart:convert';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chips_demowebsite/globals.dart' as globals;
import 'package:http_parser/http_parser.dart';

final AuthController auth = Get.put(AuthController());

String hostUrl = globals.hostUrl;
String fileUploadUrl = globals.fileUploadUrl;

Future postRequestAuthenticated({required String endpoint, data}) async {
  try {
    var authToken = auth.getAuthToken();
    if (authToken != null) {
      final url = '$hostUrl/api$endpoint';
      final response = await http.post(Uri.parse(url),
          headers: {"auth-token": authToken}, body: data);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          return result;
        } else {
          return result;
        }
      } else if (response.statusCode == 401) {
        return {
          "error": true,
          "success": false,
          "auth": false,
          "message": "Invalid Token"
        };
      } else {
        return {"error": true, "success": false, "message": "Network Error"};
      }
    } else {
      return {
        "error": true,
        "success": false,
        "auth": false,
        "message": "Invalid Token"
      };
    }
  } catch (e) {
    return {"error": true, "success": false, "message": "Network Error"};
  }
}

Future postRequestUnAuthenticated(
    {required String endpoint, Map<String, String>? headers, data}) async {
  try {
    final url = '$hostUrl/api$endpoint';
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result["success"] == true) {
        return result;
      } else {
        return result;
      }
    } else if (response.statusCode == 401) {
      return {
        "error": true,
        "success": false,
        "auth": false,
        "message": "Invalid Token"
      };
    } else {
      return {"error": true, "success": false, "message": "Network Error"};
    }
  } catch (e) {
    return {"error": true, "success": false, "message": "Network Error"};
  }
}

Future getRequestAuthenticated({required String endpoint}) async {
  try {
    var authToken = auth.getAuthToken();
    if (authToken != null) {
      final url = '$hostUrl/api$endpoint';
      final response =
          await http.get(Uri.parse(url), headers: {"auth-token": authToken});
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          return result;
        } else {
          return result;
        }
      } else if (response.statusCode == 401) {
        return {
          "error": true,
          "success": false,
          "auth": false,
          "message": "Invalid Token"
        };
      } else {
        return {"error": true, "success": false, "message": "Network Error"};
      }
    } else {
      return {
        "error": true,
        "success": false,
        "auth": false,
        "message": "Invalid Token"
      };
    }
  } catch (e) {
    return {"error": true, "success": false, "message": "Network Error"};
  }
}

Future addFileToAWSServiceWeb(fileBytes) async {
  try {
    final request =
        http.MultipartRequest('POST', Uri.parse('$fileUploadUrl/api/upload'));
    request.files.add(await http.MultipartFile.fromBytes('file', fileBytes,
        filename: '${DateTime.now()}.pdf',
        contentType: MediaType.parse("application/pdf")));
    final response = await request.send();
    if (response.statusCode == 200) {
      print('File uploaded successfully!');
      final respStr = await response.stream.bytesToString();
      return jsonDecode(respStr);
    } else {
      print('Error uploading File: ${response.reasonPhrase}');
      final respStr = await response.stream.bytesToString();
      return {"message": "Error"};
    }
  } catch (e) {
    print('Error uploading video: $e');
  }
}

Future<void> sendTokenToServer(String idToken) async {
  final response = await http.post(
    Uri.parse('http://yourbackend.com/api/auth/googleSignIn'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'token': idToken,
    }),
  );
  if (response.statusCode == 200) {
    // Handle success
  } else {
    // Handle error
  }
}

// Future<void> sendVerificationEmail(String email) async {
//   // isLoading(true);
//   try {
//     final response = await http.post(
//       Uri.parse('YOUR_BACKEND_URL/register'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//       }),
//     );

//     if (response.statusCode == 200) {
//       Get.snackbar('Success', 'Verification code sent to your email.');
//     } else {
//       Get.snackbar('Error', 'Failed to register.');
//     }
//   } finally {
//     // isLoading(false);
//   }

// }
Future<void> sendVerificationCode(String email) async {
  // Replace with your backend URL
  final response = await http.post(
    Uri.parse('https://your-backend-service.com/request-code'),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    print('Verification code sent');
  } else {
    print('Error sending verification code');
  }
}

Future<void> verifyCode(String email, String code) async {
  // Replace with your backend URL for code verification
  final response = await http.post(
    Uri.parse('https://your-backend-service.com/verify-code'),
    body: {
      'email': email,
      'code': code,
    },
  );

  if (response.statusCode == 200) {
    print('Code verified successfully');
    // Navigate to your app's home screen or next relevant page
  } else {
    print('Error verifying code');
  }
}

// Future<void> verifyCode(String email, String code) async {
//   // isLoading(true);
//   try {
//     final response = await http.post(
//       Uri.parse('YOUR_BACKEND_URL/verify-code'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//         'code': code,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // isVerified(true);
//       Get.snackbar('Success', 'Email verified successfully.');
//       auth.isLoggedIn.value = true;
//       Get.offAllNamed('/');
//     } else {
//       Get.snackbar('Error', 'Invalid or expired code.');
//     }
//   } finally {
//     // isLoading(false);
//   }
// }

// Future<void> resendVerificationCode(String email) async {
//   // isLoading(true);
//   try {
//     final response = await http.post(
//       Uri.parse('YOUR_BACKEND_URL/resend-code'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//       }),
//     );

//     if (response.statusCode == 200) {
//       Get.snackbar('Success', 'New verification code sent to your email.');
//     } else {
//       Get.snackbar('Error', 'Failed to resend verification code.');
//     }
//   } catch (e) {
//     Get.snackbar('Error', 'An error occurred while resending the code.');
//   } finally {
//     // isLoading(false);
//   }
// }
