import 'package:clima_weather/screens/location_screen.dart';
import 'package:clima_weather/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    final weatherData = await WeatherModel().getLocationWeather();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: weatherData)));
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SpinKitDoubleBounce(
      color: Colors.blue,
    )));
  }
}
