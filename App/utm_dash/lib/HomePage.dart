import 'package:flutter/material.dart';
import 'package:utm_dash/CustLoginPage.dart';
import 'package:utm_dash/AdminLoginPage.dart';
import 'package:utm_dash/HubLoginPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UTMDASH'),
        backgroundColor: Color(0xFFBE1C2D),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFBE1C2D),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  // Add your desired text style properties here
                  fontWeight: FontWeight.bold,
                  // Other properties...
                ),
              ),
              onTap: () {
                _showLoginMenu(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFBE1C2D),
          image: DecorationImage(
            image: AssetImage(
                "assets/images/your_image.png"), // Replace with your actual image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFFBE1C2D).withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/UTMDASH_LOGO.png", // Replace with your actual welcome image path
                height: 600, // Set the desired height
                width: 600, // Set the desired width
              ),
              SizedBox(height: 20),
              Transform.translate(
                offset: Offset(0, -100),
                child: Text(
                  'Welcome to Our App!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoginMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Customer'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustLoginPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Admin'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLoginPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Hub'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HubLoginPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
