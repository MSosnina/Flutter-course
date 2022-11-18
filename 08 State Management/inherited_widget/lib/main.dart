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
      title: 'inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Inherited Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
      ),
      body: ListView(children: <Widget>[
        MyInheritedWidget(
          myState: this,
          child: AppRootWidget(),
        )
      ]),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Text('(Root Widget)',
              style: Theme.of(context).textTheme.displayMedium),
          Text('${rootWidgetState?.counterValue}', style: Theme.of(context).textTheme.displayMedium),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Counter(),
              Counter(),
            ],
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        children: <Widget>[
          Text('(Child Widget)'),
          Text('${rootWidgetState?.counterValue}', style: Theme.of(context).textTheme.displayMedium),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                color: Colors.red,
                onPressed: () {rootWidgetState?._decrementCounter();},
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.green,
                onPressed: () {rootWidgetState?._incrementCounter();},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final _MyHomePageState myState;

  MyInheritedWidget({Key? key, required Widget child, required this.myState})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
