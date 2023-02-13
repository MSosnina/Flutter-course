import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/api/weater_api.dart';
import 'package:weather_app/models/weather_forecast_5day.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecastObject;
  String _cityName = 'London';

  @override
  void initState(){
    super.initState();
    forecastObject = WeatherApi().fetchWeatherForecastWithCity(cityName: _cityName);

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
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: (){

          },
        ),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.location_city))
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
                  ]);
                } else {
                  return Center(
                    child: SpinKitDoubleBounce(color: Colors.black87, size: 100),
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
