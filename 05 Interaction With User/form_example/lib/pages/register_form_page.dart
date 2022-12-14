import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/material_state.dart';
import 'package:form_example/pages/user_info_page.dart';

import '../model/user.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Russia', 'Turkey', 'USA', 'France'];
  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              //validator: (val) => (val!.isEmpty) ? 'Named is required' :null,
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Where we can reach you?',
                helperText: 'Phone format: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'[()\d-]{1,15}$'),
                    allow: true),
              ],
              validator: (value) => _validatePhoneNumer(value)
                  ? null
                  : 'Phone number must be entered as (###)###-####',
              onSaved: (value) => newUser.phone = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter an email address',
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              //validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(
                  () {
                    _selectedCountry = country!;
                    newUser.country = country;
                  },
                );
              },
              value: _selectedCountry,
              /*validator: (val) =>
                  val == null ? 'Please select a country' : null,

              */
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short, this is just a demo',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              decoration: InputDecoration(
                  labelText: 'Password *',
                  hintText: 'Enter the password',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                  icon: Icon(Icons.security)),
              validator: _validatePassword,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              decoration: InputDecoration(
                  labelText: 'Confirm Password *',
                  hintText: 'Confirm the password',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                  icon: Icon(Icons.border_color)),
              validator: _validatePassword,
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: _submitForm,
              child: Text(
                'Submit Form',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Story: ${_storyController.text}');
    } else {
      _showMessage('Form is not valid! Please review and correct.');
    }
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    if (value == '') {
      return "Name is required.";
    } else if (nameExp.hasMatch(value!)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumer(String? input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input!);
  }

  String? _validateEmail(String? value) {
    if (value == '') {
      return "Email cannot be empty";
    } else if (!_emailController.text.contains("@")) {
      return 'Invalid email address.';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) {
      return '8 character required for password.';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Password does not match.';
    } else {
      return null;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        )));
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Registration successful',
                  style: TextStyle(color: Colors.green)),
              content: Text(
                "$name is now a varified register form",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserInfoPage(
                                userInfo: newUser,
                              )));
                    },
                    child: Text('Verified',
                        style: TextStyle(color: Colors.green, fontSize: 18.0)))
              ]);
        });
  }
}
