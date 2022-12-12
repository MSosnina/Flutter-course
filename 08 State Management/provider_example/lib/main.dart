import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

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
          FutureProvider<List<User>>(
              create: (_) async => UserProvider().loadUserData(),
              initialData: []),
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
                    Tab(
                      icon: Icon(Icons.add),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.message),
                    ),
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
      ),
    );
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
          Text(
            '${_state.counterValue}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                color: Colors.deepOrange,
                onPressed: () {
                  _state._decrementCounter();
                },
              ),
              Consumer<CountProvider>(builder: (context, value, child) {
                return IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () {
                    value._incrementCounter();
                  },
                );
              })
            ],
          )
        ],
      )),
    );
  }
}

class MyUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureProvider Example, users loaded from a file',
              style: TextStyle(fontSize: 17)),
        ),
        Consumer<List<User>>(builder: (context, List<User> users, _) {
          return Expanded(
            child: users.length == 0
                ? Container(child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.grey[(index * 200) % 400],
                        child: Center(
                            child: Text(
                                '${users[index].firstName} ${users[index].lastName} | ${users[index].website}')),
                      );
                    },
                  ),
          );
        })
      ],
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
          Text('MyEventPage', style: TextStyle(fontSize: 20)),
        ],
      )),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;

  int get counterValue => _count;

  void _incrementCounter() {
    _count++;
    notifyListeners();
  }

  void _decrementCounter() {
    _count--;
    notifyListeners();
  }
}

class User {
  final String firstName, lastName, website;

  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : this.firstName = json['first_name'],
        this.lastName = json['last_name'],
        this.website = json['website'];
}

class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.fromJson(List<dynamic> userJson)
      : users = userJson.map((user) => User.fromJson(user)).toList();
}

class UserProvider {
  final String _dataPath = "assets/users.json";
  List<User> users = [];

  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    print('done loading user!' /*+ jsonEncode(users) */);
    return users;
  }
}
