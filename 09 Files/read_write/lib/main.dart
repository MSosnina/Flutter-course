import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReadWriteFileExample(),
    );
  }
}

class ReadWriteFileExample extends StatefulWidget {
  @override
  _ReadWriteFileExampleState createState() => _ReadWriteFileExampleState();
}

class _ReadWriteFileExampleState extends State<ReadWriteFileExample> {
  final TextEditingController _textController = TextEditingController();
  static const String klocalFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = klocalFileName;

  @override
  void initState() {
    super.initState();
    this._readTextFromLocalFile();
    this._getLocaFile.then((file) => setState(() => this._localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Local file read/write Demo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text('Write to local file',
              style: Theme.of(context).textTheme.titleLarge),
          TextField(
              focusNode: textFieldFocusNode,
              controller: _textController,
              maxLines: null,
              style: Theme.of(context).textTheme.titleMedium),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                  child: Text('Load', style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    this._readTextFromLocalFile();
                    this._textController.text = this._localFileContent;
                    FocusScope.of(context).requestFocus(textFieldFocusNode);
                    log('String successfuly loaded from local file');
                  }),
              MaterialButton(
                  child: Text('Save', style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    await this._writeTextLocalFile(this._textController.text);
                    this._textController.clear();
                    await this._readTextFromLocalFile();
                    log('String successfu written to local file');
                  }),
            ],
          ),
          Divider(height: 20),
          Text('Local file path:',
              style: Theme.of(context).textTheme.titleMedium),
          Text(this._localFilePath, style: Theme.of(context).textTheme.titleSmall),
          Divider(height: 20),
          Text('Local file content:',
              style: Theme.of(context).textTheme.titleMedium),
          Text(this._localFileContent, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }

  Future<String> get _getLocalPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _getLocaFile async{
    final path = await _getLocalPath;
    return File('$path/$klocalFileName');
  }

  Future <File> _writeTextLocalFile(String text) async{
    final file = await _getLocaFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocalFile() async{
    String content;
    try{
      final file = await _getLocaFile;
      content = await file.readAsString();
    } catch(e){
      content = 'Error loading local file: $e';
    }

    setState(() {
      this._localFileContent = content;
    });
  }
}
