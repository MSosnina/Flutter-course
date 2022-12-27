import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool light = true;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool light = true;

    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ColorProvider>.value(value: ColorProvider()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("Homework Provider"),
            centerTitle: true,
          ),
          body: const MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => WidgetBody();
}

class WidgetBody extends State<MyStatefulWidget> {
  @override
  bool light = false;

  Widget build(BuildContext context) {
    ColorProvider _state = Provider.of<ColorProvider>(context);

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          AnimatedContainer(
            width: 200,
            height: 200,
            color: _state.colorValue,
            alignment: Alignment.center,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
          ),
          Switch(
              value: light,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                }
                );
                print('1');
                _state._randomColor;
                print('${_state.colorValue}');
                print('${_state.i}');
              })
        ]));
  }
}

class ColorProvider extends ChangeNotifier {
  Color _color = Color(0xFF000000);
  int i =0;

  Color get colorValue => _color;

  void _randomColor() {
    _color =  Color(0xAA123456);
    i= 5;
    //    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }
}
