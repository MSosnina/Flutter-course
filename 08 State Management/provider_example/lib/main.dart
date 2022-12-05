import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
        ],

        child: DefaultTabController(
          length: 3,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Provider Demo"),
                centerTitle: true,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.add),),
                    Tab(icon: Icon(Icons.person),),
                    Tab(icon: Icon(Icons.message),),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  MyCountPage(),
                  MyUserPage(),
                  MyEventPage(),
                ],
              ),
            ),
          ),
        ),
      ),);
  }
}

class MyCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context);

    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('ChangeNotifierProvider Example',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 50),
              Text('${_state.counterValue}', style: Theme
                  .of(context)
                  .textTheme
                  .displayMedium,),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    color: Colors.deepOrange,
                    onPressed: () {_state._decrementCounter();},
                  ),
                  Consumer<CountProvider>(
                      builder: (context, value, child){
                        return IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          onPressed: () {value._incrementCounter();},
                        );
                      })
                ],
              )
            ],
          )
      ),
    );
  }
}

class MyUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('MyUserPage',
                  style: TextStyle(fontSize: 20)),
            ],
          )
      ),
    );
  }
}

class MyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('MyEventPage',
                  style: TextStyle(fontSize: 20)),
            ],
          )
      ),
    );
  }
}

class CountProvider extends ChangeNotifier{
  int _count = 0;
  int get counterValue => _count;

  void _incrementCounter(){
    _count++;
    notifyListeners();
  }

  void _decrementCounter(){
    _count--;
    notifyListeners();
  }
}