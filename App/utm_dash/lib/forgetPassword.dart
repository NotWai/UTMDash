// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utm_dash/services/auth.dart';
import 'emailSent.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Forgot your password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'That is okay. It happens! Enter your email below to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Email Input Field with label and example email
                  TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'e.g. example@gmail.com',
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Email is required. Please Enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _auth.resetPassword(email);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailSent()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        elevation: 20,
                        shadowColor: Theme.of(context).primaryColor,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
    ),
  );
}
