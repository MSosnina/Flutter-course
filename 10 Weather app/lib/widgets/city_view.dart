import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';

import '../ulilities/forecast_util.dart';

class CityView extends StatelessWidget {

  final AsyncSnapshot<WeatherForecast> snapshort;
  const CityView({required this.snapshort});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshort.data?.list!;
    var city  =  snapshort.data?.city?.name;
    var country =  snapshort.data?.city?.country;
    var formattedDate = DateTime.fromMicrosecondsSinceEpoch(forecastList![0].dt! * 1000000);

    return Container(
      child: Column(
        children: <Widget>[
          Text('$city, $country', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black87),),
          Text('${Util.getFormattedDate(formattedDate)}', style: TextStyle(fontSize: 15.0,),)
        ],
      )
    );
  }
}
