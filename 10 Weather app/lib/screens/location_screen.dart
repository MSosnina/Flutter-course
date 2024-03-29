import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/api/weater_api.dart';
import 'package:weather_app/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  void getLocationData() async{
    try{
      var weatherInfo = await WeatherApi().fetchWeatherForecast();

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return WeatherForecastScreen(locationWeather:  weatherInfo);
      }));
    }
    catch(e){
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.black87, size: 100.0,),
      )
    );
  }
}
