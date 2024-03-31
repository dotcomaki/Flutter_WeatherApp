// ignore_for_file: avoid_print

import 'package:app/models/weather_model.dart';
import 'package:app/pages/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('9d767554a7d26e466ef1931f2b171b2e');
  Weather? _weather;

  //fetch weather service
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get the weather for this city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/mist.json';
      case 'smoke':
        return 'assets/smoke.json';
      case 'haze':
        return 'assets/haze.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'snow':
        return 'assets/snow.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //icon
          const Icon(
            Icons.location_on,
            size: 40.0,
            color: Colors.black,
          ),

          // city name
          Text(
            _weather?.cityName ?? '...loading city',
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          // animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temperature
          Text(
            '${_weather?.temperature.round()}°C',
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          // weather condition
          Text(
            _weather?.mainCondition ?? '',
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    ));
  }
}
