import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                    child: Padding(
                      child: TextField(
                          cursorColor: Colors.blueGrey[800],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter City Name',
                              hintStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.black87,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none
                              ),
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.black87,
                                size: 50,
                              )
                          ),
                          onChanged: (value) {
                            cityName = value;
                          },
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, cityName);
                  },
                  child: Text('Get Weather', style: TextStyle(fontSize: 30),),
                ),
              ],
            ),
          ),
        ));
  }
}
