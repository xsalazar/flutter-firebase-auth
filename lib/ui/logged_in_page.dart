import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedInPage extends StatelessWidget {
  final FirebaseUser firebaseUser;
  final FirebaseAuth firebaseAuth;

  const LoggedInPage({
    Key key,
    @required this.firebaseUser,
    @required this.firebaseAuth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Successfully Logged In'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Signed in as: ${firebaseUser.email}'),
            RaisedButton(
              child: Text('Sign out'),
              onPressed: () async {
                await firebaseAuth.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}