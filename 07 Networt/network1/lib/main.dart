import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network1/offices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Future<OfficesList>? officesList;

  @override
  void initState() {
    super.initState();
//    loadData();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Networking'),
        ),
        body: FutureBuilder<OfficesList>(
          future: officesList,
          builder: (context, snapsot) {
            if (snapsot.hasData) {
              return ListView.builder(
                  itemCount: snapsot.data?.offices.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      title: Text('${snapsot.data?.offices[index].name}'),
                      subtitle: Text('${snapsot.data?.offices[index].address}'),
                      leading: Image.network(
                          '${snapsot.data?.offices[index].image}'),
                      isThreeLine: true,
                    ));
                  });
            } else if (snapsot.hasError) {
              return Text('Error');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

Future<http.Response> getData() async {
  Uri url = Uri.parse('https://about.google/static/data/locations.json');
  return await http.get(url);
}

void loadData() {
  getData().then((response) {
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }).catchError((error) {
    debugPrint(error.toString());
  });
}
