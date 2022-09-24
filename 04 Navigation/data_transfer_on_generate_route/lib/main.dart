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
      home: FirstHome(),
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/':
            return MaterialPageRoute(builder: (context) => FirstHome());
            break;
          case '/second':
            User user = settings.arguments as User;
            return MaterialPageRoute(builder: (context) => SecondHome(user));
            break;

        }
      },
    );
  }
}

class FirstHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First home'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            User Angi = User('Angi', 32);
            Navigator.pushNamed(context, '/second', arguments: Angi);
          },
          child: Text('Second Home'),
        ),
      ),
    );
  }
}

class SecondHome extends StatelessWidget {
  final User? user;
  SecondHome(this.user);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('${this.user?.name} - ${this.user?.age}'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('First Home'),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int age;

  User(this.name, this.age);
}
