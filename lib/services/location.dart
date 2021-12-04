import 'package:geolocator/geolocator.dart';

class LocationService {
  double? latitude;
  double? longitude;

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _getLocation();
    } else if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('permission denied');
    } else {
      print('permission...ughh I don\'t knowww');
    }
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
    print(longitude);
  }
}
