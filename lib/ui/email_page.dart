import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/ui/logged_in_page.dart';

class EmailPage extends StatefulWidget {
  final FirebaseAuth firebaseAuth;

  const EmailPage({
    Key key,
    @required this.firebaseAuth
  }) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with email'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (String value) {
                  return value.isEmpty ? 'Please enter your email' : null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (String value) {
                  return value.isEmpty ? 'Please enter a password' : null;
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Create Account'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _createAccountWithEmailAndPassword();
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('Sign In'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    }
                  )
                ],
              ) 
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null ? '' : 'Sign in failed: $_errorMessage',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = await widget.firebaseAuth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (user != null) {
      setState(() {
        _success = true; 
      });
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => LoggedInPage(firebaseAuth: widget.firebaseAuth, firebaseUser: user)));
    }
  }

  void _createAccountWithEmailAndPassword() async {
    try {
      final FirebaseUser user = await widget.firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );

      if (user != null) {
        setState(() {
         _success = true; 
        });
        Navigator.push(context, MaterialPageRoute<void>(builder: (_) => LoggedInPage(firebaseAuth: widget.firebaseAuth, firebaseUser: user)));
      }
    } on PlatformException catch (e){
      setState(() {
        _success = false;
        _errorMessage = e.message;
      });
    }
  }
}