import 'package:flutter/material.dart';
import 'package:utm_dash/HomePage.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/viewCustomerPage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    if(user == null){
      return HomePage();
    }
    else{
      return CustomerPage();
    }


  }
}