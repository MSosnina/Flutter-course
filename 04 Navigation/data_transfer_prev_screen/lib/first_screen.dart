import 'package:flutter/material.dart';
import 'package:data_transfer_prev_screen/second_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Some Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 24),
                  )),
              TextButton(
                  onPressed: () {
                    _returnDataFromSecondScreen(context);
                  },
                  child: Text(
                    'Go to second screen',
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        ));
  }

  void _returnDataFromSecondScreen(BuildContext context) async {
    Route route = MaterialPageRoute(builder: (context) => SecondScreen());
    final result = await Navigator.push(context, route);

    setState(() {
      text = result;
    });
  }
}
