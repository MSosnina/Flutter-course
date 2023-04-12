import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/api/weater_api.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/detail_view.dart';
import 'package:weather_app/widgets/temp_view.dart';
import 'package:weather_app/widgets/bottom_list_view.dart';

class WeatherForecastScreen extends StatefulWidget {

  final locationWeather;
  WeatherForecastScreen({this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecastObject;
  String? _cityName;

  @override
  void initState(){
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }

    // forecastObject?.then((weather){
    //   print(weather.list![0]?.weather![0]?.main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('openweathermap.org'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: (){
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecast();
            });
          },
        ),
        actions: <Widget>[
          IconButton(onPressed: () async{
            var tappedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CityScreen();
            }));
            if (tappedName != null) {
              setState(() {
                _cityName = tappedName;
                forecastObject = WeatherApi().fetchWeatherForecast(
                    cityName: _cityName, isCity: true);
              });
            }
          }, icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return Column(children: [
                    SizedBox(height: 50,),
                    CityView(snapshort: snapshot,),
                    SizedBox(height: 50,),
                    TempView(snapshot: snapshot),
                    SizedBox(height: 50,),
                    DetailView(snapshot: snapshot),
                    SizedBox(height: 50,),
                    BottomListView(snapshot: snapshot),
                  ]);
                } else {
                  return Center(
                    child: Text('City not found \nPlease, enter correct city',
                                style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
