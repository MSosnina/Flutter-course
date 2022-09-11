import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            title: Text("My First App"),
            centerTitle: true,
          ),
          body: Center(
              child: Text("This is my homepage",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))))));
}
