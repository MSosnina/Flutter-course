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
            title: const Text("Building layouts"),
            centerTitle: true,
          ),
          body: //const Padding(
          //padding: EdgeInsets.only(left: 50, top: 60),
          //const Align(
          //    alignment: Alignment.center,
          //const Center(
          /*
          Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(30),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: Colors.amber, border: Border.all()),
              width: 200,
              height: 100,
              child: const Text('Hello flutter', style: TextStyle(fontSize: 30))),
         */
          /*
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.network(
                    'http://sun9-77.userapi.com/impg/s67jXSJlXVlR8LysDfaTJkBea0QsEDV9zMbFVA/O0ILVtRUcyc.jpg?size=739x869&quality=96&sign=bb2caddd454e5aadcb769b1f634489ee&type=album'),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.red,
                  child: Text('1'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.green,
                  child: Text('2'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.blue,
                  child: Text('3'),
                ),
              ),
            ],
          ),
          */
          Stack(
            alignment: Alignment.center,
            children: const <Widget>[
            Icon(Icons.airplay, color: Colors.red, size: 200),
            Positioned(
                top: 60,
                left: 45,
                child: Text(
                'TV',
                style: TextStyle(fontSize: 30),
          ))
      ],
    )));
  }
}
