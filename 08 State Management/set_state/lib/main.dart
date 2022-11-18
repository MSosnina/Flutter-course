import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanila Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _rating  = 0;

  @override
  Widget build(BuildContext context){
    double _size = 50;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Vanilla Demo'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: (_rating >= 1 ?
                Icon(Icons.star, size: _size,):
                Icon(Icons.star_border, size: _size,)),
                color: Colors.indigo[500],
                iconSize: _size,
                onPressed: () {
                  setState(() {
                    _rating = 1;
                  });
                },
              ),
            ),
            Container(
              child: IconButton(
                icon: (_rating >= 2 ?
                Icon(Icons.star, size: _size,):
                Icon(Icons.star_border, size: _size,)),
                color: Colors.indigo[500],
                iconSize: _size,
                onPressed: () {
                  setState(() {
                    _rating = 2;
                  });
                },
              ),
            ),
            Container(
              child: IconButton(
                icon: (_rating >= 3 ?
                Icon(Icons.star, size: _size,):
                Icon(Icons.star_border, size: _size,)),
                color: Colors.indigo[500],
                iconSize: _size,
                onPressed: () {
                  setState(() {
                    _rating = 3;
                  });
                },
              ),
            )
          ],
        )
      ),
    );
  }
}
