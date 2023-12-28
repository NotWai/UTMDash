import 'package:flutter/material.dart';

class EmailSent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email, // Use Icons.email instead of icon: Icon(Icons.email)
              size: 100, // Set the size of the icon as needed
              color: Colors.red[300], // Set the color of the icon
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 300,
              child: Text(
                'Reset email has been sent to your mail box!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[700],
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
