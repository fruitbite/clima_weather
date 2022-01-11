import 'package:clima_weather/screens/city_screen.dart';
import 'package:clima_weather/services/weather_service.dart';
import 'package:clima_weather/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.weatherData}) : super(key: key);
  final dynamic weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weatherModel = WeatherModel();

  int? temperature;
  String? weatherMessege;
  String? weatherIcon;
  String? cityName;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateWeather() async {
    final weatherData = await weatherModel.getLocationWeather();
    setState(() {
      updateUI(weatherData);
    });
  }

  void updateCityWeather(String cityName) async {
    final weatherData = await weatherModel.getCityWeather(cityName);
    setState(() {
      updateUI(weatherData);
    });
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      setState(() {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessege = 'Unable to get weather data';
        cityName = '';
        return;
      });
    } else if (weatherData != null) {
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      weatherMessege =
          ('${weatherModel.getMessage(temperature!)} in $cityName');
      print('$condition, $temperature, $cityName');
    } else {
      //location services disabled
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () => updateWeather(),
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final dynamic typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      if (typedName != null || typedName == '') {
                        updateCityWeather(typedName);
                      } else {}
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessege!,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
