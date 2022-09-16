import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Weather forecast",
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _cityDetail(),
                    _Separator(),
                    _temperatureDetail(),
                    _Separator(),
                    _extraWeatherDetail(),
                    _Separator(),
                    _weatherForecastHeader(),
                    _weatherForecastBody(),
                  ],
                )))
      ],
    ),
  );
}

Column _cityDetail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      TextField(
        style: TextStyle(color: Colors.white, decorationColor: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 30, color: Colors.white),
          ),
          labelText: 'Enter City Name',
          prefixIcon: Icon(Icons.search),
        ),
      ),
      Container(
        height: 40,
      ),
      Text(
        'Murmansk Oblast, RU',
        style: TextStyle(color: Colors.white, fontSize: 35),
      ),
      Container(
        height: 5,
      ),
      Text(
        'Friday, Mar 20, 2020',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ],
  );
}

Row _temperatureDetail() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(
        Icons.wb_sunny,
        color: Colors.white,
        size: 60,
      ),
    ]),
    SizedBox(width: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(children: <Widget>[
          Text(
            '14° F',
            style: TextStyle(color: Colors.white, fontSize: 40),
          )
        ]),
        Row(children: <Widget>[
          Text(
            'LIGHT SNOW',
            style: TextStyle(color: Colors.white),
          )
        ]),
      ],
    ),
  ]);
}

Row _extraWeatherDetail() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.ac_unit,
        color: Colors.white,
        size: 60,
      ),
      Text('5', style: TextStyle(fontSize: 20, color: Colors.white)),
      Text('km/hr', style: TextStyle(color: Colors.white)),
    ]),
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.ac_unit,
        color: Colors.white,
        size: 60,
      ),
      Text('3', style: TextStyle(fontSize: 20, color: Colors.white)),
      Text('%', style: TextStyle(color: Colors.white)),
    ]),
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.ac_unit,
        color: Colors.white,
        size: 60,
      ),
      Text('20', style: TextStyle(fontSize: 20, color: Colors.white)),
      Text('%', style: TextStyle(color: Colors.white)),
    ]),
  ]);
}

Widget _temperatureForecast() {
  return ListView(
    //shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      dayContainer('Friday'),
      emptyContainer(),
      dayContainer('Suturday'),
      emptyContainer(),
      dayContainer('Sunday'),
      emptyContainer(),
      dayContainer('Monday'),
      emptyContainer(),
    ],
  );
}

Container dayContainer(String day) {
  return Container(
    padding: EdgeInsets.all(20),
    width: 160,
    height: 50,
    color: Colors.grey.shade300,
    child: Column(children: [
      Center(
          child: Text(
        '$day',
        style: TextStyle(fontSize: 30, color: Colors.white),
      )),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '6° F',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        Icon(
          Icons.sunny,
          size: 30,
          color: Colors.white,
        )
      ])
    ]),
  );
}

Container emptyContainer() {
  return Container(
    width: 10,
    height: 50,
  );
}

Widget _weatherForecastBody(){
 return SizedBox(
   height: 150,
   child: _temperatureForecast(),);
}


Widget _weatherForecastHeader(){
  return Text(
    '7-DAY WEATHER FORECAST',
    style: TextStyle(color: Colors.white, fontSize: 20),
  );
}

Container _Separator(){
  return Container(
    height: 40,
  );
}