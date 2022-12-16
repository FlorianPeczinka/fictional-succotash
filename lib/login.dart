import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                // Sign in with email and password
                try {
                  UserCredential result =
                      await _auth.signInWithEmailAndPassword(
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
              child: Text('Sign in with Email and Password'),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: () async {
                // Sign in with Google
                try {
                  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                  GoogleSignInAuthentication googleAuth =
                      await googleUser.authentication;
                  UserCredential result = await _auth.signInWithGoogle(
                    idToken: googleAuth.idToken,
                    accessToken: googleAuth.accessToken,
                  );
                  User user = result.user;
                  // Navigate to the home page
                  Navigator.pushNamed(context, '/home');
                } catch (e) {
                  // Show error message
                  print(e.message);
                }
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
