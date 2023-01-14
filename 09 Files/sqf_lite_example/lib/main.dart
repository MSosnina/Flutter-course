import 'package:flutter/material.dart';
import 'package:sqf_lite_example/db/database.dart';
import 'package:sqf_lite_example/model/student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();

  Future<List<Student>>? _studentsList;
  String _studentName = '';
  bool isUpdate = false;
  int studentIdForUpdate = 0;
  //List<Student>? students;

  @override
  void initState() {
    super.initState();
    updateStudentList();
  }

  updateStudentList() {
    setState(() {
      _studentsList = DBProvider.db.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD Demo'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return 'Please Enter Student Name';
                      }
                      else if (value?.trim() == "") {
                        return 'Only Space is Not Valid';
                      }
                      else return null;
                    },
                    onSaved: (value) {
                      _studentName = value!;
                    },
                    controller: _studentNameController,
                    decoration: InputDecoration(
                      focusedBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.greenAccent,
                              width: 2,
                              style: BorderStyle.solid)),
                      labelText: "Student Name",
                      icon: Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  )),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  (isUpdate ? "UPDATE" : "ADD"),
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();
                      DBProvider.db
                          .updateStudent(
                              Student(studentIdForUpdate, _studentName))
                          .then(
                        (data) {
                          setState(
                            () {
                              isUpdate = false;
                            },
                          );
                        },
                      );
                    }
                  } else {
                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();
                      DBProvider.db.insertStudent(Student(null, _studentName));
                    }
                  }
                  _studentNameController.text = '';
                  updateStudentList();
                },
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  _studentNameController.text = '';
                  setState(() {
                    isUpdate = false;
                    studentIdForUpdate = 0;
                  });
                },
                child: Text(
                  (isUpdate ? "CANCEL UPDATE" : "CLEAR"),
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                ),
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: _studentsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data!);
                }
                if (snapshot.data == null || snapshot.data?.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Student> _studentsList) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(label: Text('NAME')),
            DataColumn(label: Text('DELETE')),
          ],
          rows: _studentsList
              .map(
                  (student) => DataRow(cells: [
                        DataCell(Text(student.name), onTap: () {
                          setState(() {
                            isUpdate = true;
                            studentIdForUpdate = student.id!;
                          });
                          _studentNameController.text = student.name;
                        }),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            DBProvider.db.deleteStudent(student.id!);
                            updateStudentList();
                          },
                        )),
                      ]))
              .toList(),
        ),
      ),
    );
  }
}
