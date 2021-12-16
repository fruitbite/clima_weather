import 'package:clima_weather/screens/location_screen.dart';
import 'package:clima_weather/services/location.dart';
import 'package:clima_weather/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../key.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  void getLocationData() async {
    await _locationService.getCurrentLocation();
    latitude = _locationService.latitude ?? 0.0;
    longitude = _locationService.longitude ?? 0.0;
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    final weatherData = await networkHelper.getData();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: weatherData)));
    // int id = weatherData['weather'][0]['id'];
    // double temperature = weatherData['main']['temp'];
    // String city = weatherData['name'];
  }

  final LocationService _locationService = LocationService();
  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitFadingCircle(
        color: Colors.blue,
      )),
    );
  }
}
