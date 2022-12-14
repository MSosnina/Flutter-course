import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First screen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: textFieldController,
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () {
                  String textToSendBack = textFieldController.text;
                  Navigator.pop(context, textToSendBack);
                },
                child: Text(
                  'Send text back',
                  style: TextStyle(fontSize: 30),
                ))
          ],
        ));
  }
}
