import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin_app/home.dart';
import 'package:flutter_firebase_signin_app/register.dart';

import 'login.dart';

void main() async {
  myRoute(state) => runApp(MaterialApp(
        initialRoute: state,
        debugShowCheckedModeBanner: false,
        routes: {
          'register': (context) => MyRegister(),
          'login': (context) => MyLogin(),
          'home': (context) => MyHome(),
        },
      ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      myRoute('login');
    } else {
      print('User is signed in!');
      myRoute('home');
    }
  });
}
