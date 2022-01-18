import 'package:flutter/material.dart';
import 'dart:math';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this.isLoding);
  final bool isLoding;
  final void Function(
    String email,
    String username,
    String password,
    bool islogin,
    BuildContext ctx,
  ) submitfn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();

  var _isLogin = true;
  var _useremail = '';
  var _username = '';
  var _userpassword = '';

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState.save();
      widget.submitfn(_useremail.trim(), _username.trim(), _userpassword.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 69.0),
              transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
              // ..translate(-10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                'My health',
                style: TextStyle(
                  // color: Theme.of(context).accentTextTheme.title.color,
                  fontSize: 20,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'IndieFlower',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Card(
            shadowColor: Colors.lightGreen,
            elevation: 30,
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        key: ValueKey('Email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter valid Email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: 'Email Address'),
                        onSaved: (value) {
                          _useremail = value;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('Username'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Username'),
                          onSaved: (value) {
                            _username = value;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('Password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Password'),
                        textInputAction: TextInputAction.done,
                        onSaved: (value) {
                          _userpassword = value;
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (widget.isLoding) CircularProgressIndicator(),
                      if (!widget.isLoding)
                        RaisedButton(
                          child: Text(
                            _isLogin ? 'Login' : 'Sign UP',
                            style: TextStyle(
                              fontFamily: 'IndieFlower',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create New Account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(
                            () {
                              _isLogin = !_isLogin;
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
