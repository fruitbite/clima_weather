import 'package:clima_weather/services/location.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final LocationService _locationService = LocationService();
  @override
  void initState() {
    _locationService.getCurrentLocation();
    print(_locationService.latitude);
    print(_locationService.longitude);
    super.initState();
  }

  void getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _locationService.getCurrentLocation();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
