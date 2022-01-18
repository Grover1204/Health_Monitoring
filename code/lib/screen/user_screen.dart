// import 'dart:js_util';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user2/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _isLoding = false;
  void _submitAuthform(
    String email,
    String username,
    String password,
    bool islogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoding = true;
      });
      if (islogin) {
        final authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'email': email,
          'username': username,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, Please check your crendentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoding = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthform,
        _isLoding,
      ),
    );
  }
}

class AuthResult {}
