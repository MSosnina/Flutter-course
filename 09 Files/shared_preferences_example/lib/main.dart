import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preference Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPreferenceExample(),
    );
  }
}

class SharedPreferenceExample extends StatefulWidget {
  @override
  _SharedPreferenceExampleState createState() =>
      _SharedPreferenceExampleState();
}

class _SharedPreferenceExampleState extends State<SharedPreferenceExample> {
  static const String kNumberPrefKey = 'number_pref';
  static const String kBoolPrefKey = 'bool_pref';

  SharedPreferences? _prefs;

  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._prefs = prefs);
        _loadNumberPref();
        _loadBoolPref();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference Demo'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                Text('Number Preference'),
                Text('${this._numberPref}'),
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: () => this._setNumberPref(this._numberPref + 1),
                )
              ]),
              TableRow(children: <Widget>[
                Text('Boolean Preference'),
                Text('${this._boolPref}'),
                ElevatedButton(
                  child: Text('Toogle'),
                  onPressed: () => this._setBoolPref(!this._boolPref),
                )
              ])
            ],
          ),
          ElevatedButton(
            child: Text('Reset Data'),
            onPressed: () => this._reserDataPref(),
          )
        ],
      ),
    );
  }

  Future<Null> _setNumberPref(int value) async {
    await this._prefs?.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await this._prefs?.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      this._numberPref = this._prefs?.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      this._boolPref = this._prefs?.getBool(kBoolPrefKey) ?? false;
    });
  }

  Future<Null> _reserDataPref() async {
    await this._prefs?.remove(kNumberPrefKey);
    await this._prefs?.remove(kBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }
}
