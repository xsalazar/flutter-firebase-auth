import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/ui/logged_in_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LogInPage extends StatefulWidget {
  final String title;

  LogInPage({
    Key key,
    this.title
  }) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  FirebaseUser _currentUser;

  @override
  void initState () {
    // Enabled persistent log-ins by checking the Firebase Auth instance for previously logged in users
    _auth.currentUser().then((user) {
      if (user != null) {
        _pushPage(context, LoggedInPage(firebaseAuth: _auth, firebaseUser: user));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              color: Colors.white,
              icon: Image.asset('images/g.png', width: 24, height: 24,),
              label: Text('Sign in with Google'),
              onPressed: () {
                _signInWithGoogle();
              },
            ),
            RaisedButton.icon(
              color: Colors.white,
              icon: Icon(Icons.email),
              label: Text('Sign in with email'),
              onPressed: () {
                _signInWithEmail();
              },
            )
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _pushPage(context, LoggedInPage(firebaseAuth: _auth ,firebaseUser: user));
    }
  }

  void _signInWithEmail() {

  }
}

// Helper method to navigate pages
void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}