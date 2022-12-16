import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => _email = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => _password = value,
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: () async {
// Create a new user with email and password
                try {
                  UserCredential result =
                      await _auth.createUserWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                  User user = result.user;
// Navigate to the home page
                  Navigator.pushNamed(context, '/home');
                } catch (e) {
                  // Show error message
                  print(e.message);
                }
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
