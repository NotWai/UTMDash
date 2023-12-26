import 'package:flutter/material.dart';
//import 'package:utm_dash/LoginPage.dart';
import 'package:utm_dash/reusable_widgets.dart';
import 'package:utm_dash/services/auth.dart';
//import 'package:utm_dash/signout.dart';
//import 'package:utm_dash/screen/signout.dart';
//import 'package:utm_dash/screen/testSignOut.dart';
//import 'package:utm_dash/utils/color_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _phoneNumTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPassTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFFBE1C2D),
          /*gradient: LinearGradient(colors: [
          hexStringToColor("FEFDFD"), //white
          hexStringToColor("FFC7D4"), //softpink
          hexStringToColor("C42031"), //red
          //hexStringToColor("0E0606"), //black
        ],*/
          //begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/UTMDASH_LOGO.png"),
                    const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Welcome!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                          ]),
                          Row(children: [
                            Text("New here? Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ]),
                        ]),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    const SizedBox(
                      height: 12,
                    ),
                    reusableTextField("Enter Full Name", Icons.person_outline,
                        false, _fullNameTextController),
                    const SizedBox(
                      height: 12,
                    ),
                    reusableTextField("Enter Phone Number",
                        Icons.phone_outlined, false, _phoneNumTextController),
                    const SizedBox(
                      height: 12,
                    ),
                    reusableTextField(
                      "Enter Email Address",
                      Icons.email_outlined,
                      false,
                      _emailTextController,
                      isEmail: true, // Set this as an email field
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    reusableTextField(
                      "Enter Password",
                      Icons.lock_outline,
                      true,
                      _passwordTextController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    reusableTextField("Confirm Password", Icons.lock_outline,
                        true, _confirmPassTextController),
                    const SizedBox(
                      height: 12,
                    ),
                    signUpSignInLogoutButton(context, true, () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.register(
                            _emailTextController.text.trim(),
                            _passwordTextController.text.trim(),
                            _fullNameTextController.text,
                            _phoneNumTextController.text);
                        if (result == null) {
                          print('Invalid login');
                        } else {
                          Navigator.pop(context);
                        }
                      }
                      ;
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
