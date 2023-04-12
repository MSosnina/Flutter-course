import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'screens/weather_forecast_screen.dart';
//https://api.openweathermap.org/data/2.5/forecast?q=Barnaul&appid=d7f50a06ef8960b7b551e58fe494f09b&units=metric

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationScreen(),
    );
  }
}
