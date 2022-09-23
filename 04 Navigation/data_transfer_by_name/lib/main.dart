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
      routes: {
        '/first': (context) => FirstHome(),
        '/second': (context) => SecondHome(),
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
  User? user;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    user = settings.arguments as User;
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
