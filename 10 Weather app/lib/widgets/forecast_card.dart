import 'package:flutter/material.dart';
import 'package:weather_app/ulilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index){
  var forecastList = snapshot.data.list;
  var dayOfWeeek = '';
  DateTime date = DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  dayOfWeeek = fullDate.split(',')[0];
  var tempMin  = forecastList[index].main?.tempMin?.toInt();
  var icon = forecastList[index].getIconUrl();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dayOfWeeek,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(8),
                  child: Text(
                    '$tempMin °C', style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
                  Image.network(icon, scale: 1.2, color: Colors.white,)
                ],
              )
            ],
          )
        ],
      )
    ],
  );
}