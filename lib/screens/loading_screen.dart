import 'package:clima_weather/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../key.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  http.Response? response;
  void getLocation() async {
    await _locationService.getCurrentLocation();
    latitude = _locationService.latitude ?? 0.0;
    longitude = _locationService.longitude ?? 0.0;
    print(longitude);
    print(latitude);
  }

  final LocationService _locationService = LocationService();
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getData() async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    response = await http.get(uri);
    if (response!.statusCode == 200) {
      String data = response!.body;
      final decodedData = jsonDecode(data);
      int id = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String city = decodedData['name'];
      print("$city, $temperature, $id");
    } else {
      print('Error: Couldn\'t get data for this location');
    }
  }

  void unpack() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getData();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
