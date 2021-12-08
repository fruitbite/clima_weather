import 'package:clima_weather/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../key.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    await _locationService.getCurrentLocation();
    print(latitude);
    print(longitude);
  }

  double get latitude => _locationService.latitude ?? 0.0;
  double get longitude => _locationService.longitude ?? 0.0;

  final LocationService _locationService = LocationService();
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getData() async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?$latitude=35&$longitude=139&appid=$apiKey');
    Response response = await get(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _locationService.getCurrentLocation();
            print(_locationService.latitude);
            print(_locationService.longitude);
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
