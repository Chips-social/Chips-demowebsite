import 'dart:convert';
import 'dart:typed_data';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:chips_demowebsite/controllers/chip_controller.dart';
import 'package:chips_demowebsite/controllers/home_controller.dart';
import 'package:chips_demowebsite/widgets/my_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chips_demowebsite/globals.dart' as globals;
import 'package:http_parser/http_parser.dart';

final AuthController auth = Get.put(AuthController());
final ChipController chipController = Get.put(ChipController());
final HomeController homeController = Get.find<HomeController>();

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

// Future addFileToAWSServiceWeb(fileBytes) async {
//   try {
//     final request =
//         http.MultipartRequest('POST', Uri.parse('$fileUploadUrl/api/upload'));
//     request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
//         filename: '${DateTime.now()}.pdf',
//         contentType: MediaType.parse("application/pdf")));
//     final response = await request.send();
//     if (response.statusCode == 200) {
//       print('File uploaded successfully!');
//       final respStr = await response.stream.bytesToString();
//       return jsonDecode(respStr);
//     } else {
//       print('Error uploading File: ${response.reasonPhrase}');
//       final respStr = await response.stream.bytesToString();
//       return {"message": "Error"};
//     }
//   } catch (e) {
//     print('Error uploading video: $e');
//   }
// }

// Future<void> sendTokenToServer(String idToken) async {
//   final url = '$hostUrl/api/google-sign';
//   final response = await http.post(
//     Uri.parse(url),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(<String, String>{
//       'token': idToken,
//     }),
//   );
//   if (response.statusCode == 200) {
//     // Handle success
//   } else {
//     // Handle error
//   }
// }

void parseAndSetSuggestions(String responseBody) {
  final parsed = jsonDecode(responseBody);
  if (parsed['status'] == 'OK' && parsed.containsKey('predictions')) {
    final List<dynamic> predictions = parsed['predictions'];
    final List<Map<String, String>> descriptions =
        predictions.map<Map<String, String>>((prediction) {
      final String description = prediction['description'];
      final String placeId = prediction['place_id'];
      final String mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$description&query_place_id=$placeId';

      return {'description': description, 'mapsUrl': mapsUrl};
    }).toList();
    chipController.suggestions.clear();
    chipController.suggestions.addAll(descriptions);
  } else {
    print('No predictions found or status not OK');
  }
}

void fetchSuggestions(String input) async {
  if (input.isEmpty) {
    chipController.suggestions.value = [];
    return;
  }
  final response = await http
      .get(Uri.parse('$hostUrl/api/places/autocomplete?input=$input'));

  if (response.statusCode == 200) {
    parseAndSetSuggestions(response.body);
  } else {}
}

Future<String> getAddressFromBackend(double latitude, double longitude) async {
  final uri = '$hostUrl/api/getAddress?latitude=$latitude&longitude=$longitude';
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['address'];
  } else {
    throw Exception('Failed to load address');
  }
}

Future<Map<String, dynamic>> fetchMetadata(String url) async {
  final response = await http.get(Uri.parse('$hostUrl/api/metadata?url=$url'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load metadata');
  }
}

Future<void> uploadImagesToS3(List<Uint8List> imageBytesList) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload'),
  );
  chipController.isLoading.value = true;

  for (int i = 0; i < imageBytesList.length; i++) {
    var bytes = imageBytesList[i];
    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'image$i.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      chipController.imageUrls = List<String>.from(responseJson['urls']);
      chipController.isLoading.value = false;
      // print('Images uploaded successfully');
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading images",
          icon: Icons.error,
          color: Colors.white);
      chipController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading images",
        icon: Icons.error,
        color: Colors.white);
    chipController.isLoading.value = false;
  }
}
