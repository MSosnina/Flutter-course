// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserInfoPage extends StatelessWidget {
  User userInfo;

  UserInfoPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('${userInfo.name}',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('${userInfo.story}'),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: Text('${userInfo.country == null ? '' : userInfo.country}'),
            ),
            ListTile(
              title: Text('${userInfo.phone}',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
            _mail(userInfo.email),
          ],
        ),
      ),
    );
  }

  // ignore: curly_braces_in_flow_control_structures
  Widget _mail(String mail) {
    if (mail.isEmpty)
      return SizedBox(height: 0);
    else
      return ListTile(
        title: Text('${mail.isEmpty ? '' : mail}',
            style: TextStyle(fontWeight: FontWeight.w500)),
        leading: Icon(
          Icons.mail,
          color: Colors.black,
        ),
      );
  }
}
