import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin_app/my_toast.dart';
import 'package:toastification/toastification.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    String email = '', pass = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                onChanged: (value) {
                  pass = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: email, password: pass);

                            MyToast.showToast(context, 'Welcome User');
                            Navigator.pushNamed(context, 'home');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              myToast('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              myToast('Wrong password provided for that user.');
                            }
                          }
                        },
                        child: const Text('Login')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text('Sign Up')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  myToast(text) => Toastification().show(
        context: context,
        title: text,
        autoCloseDuration: const Duration(seconds: 5),
      );
}
