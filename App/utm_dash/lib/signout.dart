import 'package:flutter/material.dart';
import 'package:utm_dash/reusable_widgets.dart';
import 'package:utm_dash/signup.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => SignOutState();
}

class SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xFFBE1C2D),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                Image.asset("assets/images/successful.png",
                    height: 200, width: 200),
                const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You are signed out of your account.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign:
                            TextAlign.center, // Set text alignment to center
                      ),
                    ]),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                signUpSignInLogoutButton(context, false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
