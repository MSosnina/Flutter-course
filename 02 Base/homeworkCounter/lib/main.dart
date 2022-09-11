import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Counter',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.indigo.shade300,
        ),
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Counter'),
                centerTitle: true,
                backgroundColor: Colors.indigo.shade700),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  const Text('Press "-" to decrement',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  CounterWidget(),
                  const Text('Press "+" to Increment',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ]))));
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 50;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.indigo.shade100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrementCounter,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _incrementCounter,
            ),
          ],
        ));
  }
}
