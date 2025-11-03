import 'dart:convert';
import 'package:intl/intl.dart';

WeatherForecast weatherForecastFromJson(String str) => WeatherForecast.fromJson(json.decode(str));

class WeatherForecast {
  final List<DailyForecast> dailyForecasts;

  WeatherForecast({required this.dailyForecasts});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastList = json["list"] ?? [];
    final dailyForecasts = <DailyForecast>[];

    // Group by date first
    final dailyForecastsMap = <String, dynamic>{};

    for (final forecast in forecastList) {
      final dateTime = forecast["dt_txt"] as String;
      final date = dateTime.split(' ')[0];

      // Only store the first forecast for each date
      if (!dailyForecastsMap.containsKey(date)) {
        dailyForecastsMap[date] = forecast;
      }
    }

    // Convert to list and take only 5 days
    int count = 0;
    for (final forecast in dailyForecastsMap.values) {
      if (count >= 5) break;

      final fullDateTime = DateTime.parse(dailyForecastsMap.values.elementAt(count)["dt_txt"]);
      String fullDayName = DateFormat('EEEE').format(fullDateTime);

      dailyForecasts.add(DailyForecast(
        day: fullDayName,
        temperature: (forecast["main"]["temp"] as num).toDouble(),
        description: forecast["weather"][0]["description"],
        icon: forecast["weather"][0]["icon"],
      ));

      count++;
    }
    return WeatherForecast(dailyForecasts: dailyForecasts);
  }
}

// Simplified data for this example
class DailyForecast {
  final String day;
  final double temperature;
  final String description;
  final String icon;

  DailyForecast({
    required this.day,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  String getIconUrl() {
    return "https://openweathermap.org/img/wn/$icon@2x.png";
  }
}




