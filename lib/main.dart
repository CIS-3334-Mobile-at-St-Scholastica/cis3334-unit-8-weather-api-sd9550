import 'package:flutter/material.dart';
import 'package:flutter_weatherapi_f25/API_Call.dart';
import 'package:flutter_weatherapi_f25/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '5-Day Weather Forecast'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<WeatherForecast> futureWeather;
  final WeatherAPI weatherAPI = WeatherAPI();

  @override
  void initState() {
    super.initState();
    futureWeather = weatherAPI.fetchDefaultWeather();
  }

  Widget weatherTile(DailyForecast daily, int position) {
    return ListTile(
      leading: Image.network(
        daily.getIconUrl(),
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.wb_sunny, size: 50, color: Colors.amber);
        },
      ),
      title: Text(
        daily.day,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(daily.description),
      trailing: Text(
        "${daily.temperature.toStringAsFixed(0)}°F",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<WeatherForecast>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.dailyForecasts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: weatherTile(snapshot.data!.dailyForecasts[index], index),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error loading weather'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureWeather = weatherAPI.fetchDefaultWeather();
                      });
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}