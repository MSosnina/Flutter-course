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
        theme: ThemeData(fontFamily: 'Qwitcher'),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Adding Assets'),
            ),
            body: Center(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/background.jpg'),
                  ),
                  Image.asset('assets/icons/icon.jpg'),
                  Positioned(
                      top: 16,
                      left: 115,
                      child: Text('My custom font',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            // fontFamily: 'Qwitcher'
                          )))
                ],
              ),
            )));
  }
}
