import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:chips_demowebsite/services/rest.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/src/url_launcher_string.dart';

class LocationController extends GetxController {

  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;


  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission ==  LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
     if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
              return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 5),
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;

  }
}

  openGoogleMaps() async {
    try {
      await getCurrentLocation();

      final url = 'https://www.google.com/maps/search/?api=1&query=${latitude.value},${longitude.value}';

      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      print('Error opening Google Maps: $e');
      // Handle errors gracefully, e.g., display an error message to the user
    }
  }
}
