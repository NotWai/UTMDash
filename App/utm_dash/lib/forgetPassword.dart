import 'package:flutter/material.dart';
import 'emailSent.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password'),
        centerTitle: true,
        backgroundColor: Colors.red,
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
                    'Please enter your email to receive forget message:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red[300],
                    ),
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
                      if (value!.isEmpty) {
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
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
