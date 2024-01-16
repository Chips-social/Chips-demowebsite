import 'dart:convert';
import 'package:chips_demowebsite/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chips_demowebsite/globals.dart' as globals;

final AuthController auth = Get.put(AuthController());

String hostUrl = globals.hostUrl;

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
