import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Weather", style: TextStyle(color: Colors.black87)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
          brightness: Brightness.light,
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
        _headerImage(),
        SafeArea(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _weatherDescription(),
                    Divider(),
                    _temperature(),
                    Divider(),
                    _temperatureForecast(),
                    Divider(),
                    _footerRatings(),
                  ],
                )))
      ],
    ),
  );
}

Image _headerImage() {
  return const Image(
    image: NetworkImage(
        'https://cdnn21.img.ria.ru/images/07e4/07/1e/1575148639_0:154:3072:1882_1920x0_80_0_0_529486b690d346bc9f3506e343f10a56.jpg'),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'Tuesday - May 22',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      Divider(),
      Text(
        'Text example',
        style: TextStyle(color: Colors.black54),
      ),
    ],
  );
}

Row _temperature() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.wb_sunny, color: Colors.yellow),
    ]),
    SizedBox(width: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(
            '15° Clear',
            style: TextStyle(color: Colors.deepPurple),
          )
        ]),
        Row(children: <Widget>[
          Text(
            'Altayskiy kray, Barnaul',
            style: TextStyle(color: Colors.grey),
          )
        ])
      ],
    ),
  ]);
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(8, (int index) {
      return Chip(
        label: Text(
          '${index + 20}°C',
          style: TextStyle(fontSize: 15),
        ),
        avatar: Icon(
          Icons.wb_cloudy,
          color: Colors.blue.shade300,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Colors.grey)),
        backgroundColor: Colors.grey.shade100,
      );
    }),
  );
}

Row _footerRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.star,
        size: 15,
        color: Colors.yellow.shade600,
      ),
      Icon(
        Icons.star,
        size: 15,
        color: Colors.yellow.shade600,
      ),
      Icon(
        Icons.star,
        size: 15,
        color: Colors.yellow.shade600,
      ),
      Icon(
        Icons.star,
        size: 15,
        color: Colors.black,
      ),
      Icon(
        Icons.star,
        size: 15,
        color: Colors.black,
      )
    ],
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        'Info with openweathermap.org',
        style: TextStyle(fontSize: 15),
      ),
      stars
    ],
  );
}
