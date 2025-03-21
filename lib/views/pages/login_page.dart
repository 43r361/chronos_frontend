import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? password;

  TextEditingController? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print(password?.text);
                print(username?.text);
              },
              child: Text('Login'),
            ),
            Divider(),
            GestureDetector(
              onTap:
                  () { launchUrlString("http://localhost:8393/auth/google/callback");
                    // TODO this might not be the best way
                  },
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: Text("Continue with apple account"),
                trailing: Icon(Icons.android),
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Text("Continue with google account"),
              trailing: Icon(Icons.apple),
            ),
          ],
        ),
      ),
    );
  }
}
