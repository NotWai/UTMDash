// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'view_runner_page.dart';

void showAccept(BuildContext context, ValueNotifier<bool>isAccepted) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('You have accepted the request!'),
        actions: [
          TextButton(
            onPressed: () {
              isAccepted.value = true;
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


void showReject(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('You have rejected the request!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
