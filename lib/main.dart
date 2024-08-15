import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend_work/foodapp.dart';

import 'package:frontend_work/signupp.dart';
import 'firebase_options.dart';


import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'SecondScreen.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  FirebaseAuth _auth = FirebaseAuth.instance;


  void login(){
    _auth.signInWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString()).then((value) {
    });

  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(title: Text('Login Form'),

              backgroundColor: Colors.blue,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }else{
                return null;
              }

            },
            keyboardType: TextInputType.emailAddress,

              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),

                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),


              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      // If login is successful, navigate to the next screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => food()));
                    } catch (e) {
                      String errorMessage = 'Please enter correct email and password.';
                      if (e is FirebaseAuthException) {
                        if (e.code == 'user-not-found') {
                          errorMessage = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage = 'Wrong password provided.';
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),

          SizedBox(height: 5),
          TextButton(
            onPressed: () {
              // Perform other login action

              Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(),));
            },
            child: Text('Create an Account'),
          )],
          ),
        ),
      ),
    );
  }
}








