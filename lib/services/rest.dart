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
