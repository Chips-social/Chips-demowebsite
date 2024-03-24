import 'package:chips_demowebsite/services/rest.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        // Permissions are denied forever or denied, can't proceed.
        return Future.error('Location permissions are denied.');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  openGoogleMaps() async {
    try {
      await getCurrentLocation();
      // print("location done");
      chipController.location.value =
          await getAddressFromBackend(latitude.value, longitude.value);
      chipController.locationUrl.value =
          'https://www.google.com/maps/search/?api=1&query=${latitude.value},${longitude.value}';
      return {
        'description': chipController.location.value,
        'mapsUrl': chipController.locationUrl.value
      };
    } catch (e) {
      print('Error opening Google Maps: $e');
    }
  }
}
