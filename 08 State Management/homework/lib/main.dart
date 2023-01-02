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
          appBar: AppBarStatefulWidget(),
          body: const MyStatefulWidget(),
        ),
      ),
    );
  }
}

class AppBarStatefulWidget extends StatefulWidget
    implements PreferredSizeWidget {
  AppBarStatefulWidget({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Size preferredSize;

  @override
  State<AppBarStatefulWidget> createState() => WidgetAppBar();
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => WidgetBody();
}

class WidgetAppBar extends State<AppBarStatefulWidget> {
  //@override

  Widget build(BuildContext context) {
    ColorProvider _state = Provider.of<ColorProvider>(context);

    return AppBar(
      title: Text(
        "Homework Provider",
        style: TextStyle(color: _state.colorValue),
      ),
      centerTitle: true,
    );
  }
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
                setState(() => light = value);
                _state._randomColor();
              })
        ]));
  }
}

class ColorProvider extends ChangeNotifier {
  Color _color = Color(0xFF000000);

  Color get colorValue => _color;

  void _randomColor() {
    _color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }
}
