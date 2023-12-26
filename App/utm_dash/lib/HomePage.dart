import 'package:flutter/material.dart';
import 'package:utm_dash/LoginPage.dart';
import 'package:utm_dash/signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTMDASH'),
        backgroundColor: const Color(0xFFBE1C2D),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
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
              title: const Text(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  // Add your desired text style properties here
                  fontWeight: FontWeight.bold,
                  // Other properties...
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFBE1C2D),
          image: DecorationImage(
            image: const AssetImage(
                "assets/images/UTMDASH_LOGO.png"), // Replace with your actual image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color(0xFFBE1C2D).withOpacity(0.2),
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
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, -100),
                child: const Text(
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
}
