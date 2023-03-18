import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const TempView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list!;
    var icon = forecastList![0].getIconUrl();
    var temp = forecastList![0]?.main?.temp?.toInt();
    var description = forecastList![0]?.weather![0]?.description?.toUpperCase();

    return Container(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(icon, scale:  0.4, color: Colors.black87,),
          SizedBox(width: 20.0,),
          Column(
            children: <Widget>[
              Text('$temp °C', style: TextStyle(fontSize: 54, color: Colors.black87),),
              Text('$description', style: TextStyle(fontSize: 18, color: Colors.black87),)
            ],
          )
        ],
      ),
    );
  }
}
