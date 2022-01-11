import 'package:geolocator/geolocator.dart';

class LocationService {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      } else if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('permission denied');
      } else {
        //cancelled
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
