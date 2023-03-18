import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';
import 'package:weather_app/ulilities/forecast_util.dart';

class DetailView extends StatelessWidget {

  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list!;
    var pressure     = (forecastList![0]?.main?.pressure!.toDouble())! * 0.750062;
    int  humidity    = (forecastList![0]?.main?.humidity!.toInt())!;
    int  wind        = (forecastList![0]?.wind?.speed!.toInt())!;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Util.getItem(FontAwesomeIcons.temperatureThreeQuarters, pressure.round(), 'mm Hg'),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind, 'm/s'),
        ],
      )
    );
  }
}
