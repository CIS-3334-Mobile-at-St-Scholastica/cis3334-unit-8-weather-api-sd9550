import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weatherapi_f25/weather_model.dart';

class WeatherAPI {
  static const String apiKey = '5aa6c40803fbb300fe98c6728bdafce7';

  Future<WeatherForecast> fetchWeatherForecast(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=imperial&cnt=40&appid=$apiKey'
    ));

    if (response.statusCode == 200) {
      return weatherForecastFromJson(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherForecast> fetchDefaultWeather() async {
    return fetchWeatherForecast('duluth');
  }
}