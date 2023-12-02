import 'package:flutter/material.dart';
import 'package:test2/CustLoginPage.dart';
import 'package:test2/HomePage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<String> images = [
    "assets/images/UTMDASH_LOGO.png",
    "assets/images/SecPic.png",
    "assets/images/register.png",
  ];

  final List<Widget> texts = [
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Welcome to Our App \n Let\'s get to know UTMDASH',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                "\n\n Our app helps you get your package easily from NINJAVAN ANGKASA hub.\nIf you are too busy to pick it up, we will send it to you.\nSave time, stay organized and receive your package without any hassle!",
          ),
        ],
      ),
    ),
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Choose Your Purpose',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                "\n\n UTMDASH is an easy-to-use app for three groups: customers, drivers, and hub users. \nIf you need a delivery, use it as a customer, and you can sign up as a courier if you want to offer delivery services. \nOur app is flexible, letting you choose the role that fits your needs best.",
          ),
        ],
      ),
    ),
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Let\'s Register Now',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n\n Let's use our app to make your day easier",
          ),
        ],
      ),
    ),
  ];
  int _currentIndex = 0;

  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 130, 11, 23), // Button color
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-up as Customer
                    Navigator.pop(context); // Close the dialog
                    // Add your logic for signing up as a Customer
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 130, 11, 23),
                  ),
                  child: Text('Sign Up as Customer'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-up as Runner
                    Navigator.pop(context); // Close the dialog
                    // Add your logic for signing up as a Runner
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 130, 11, 23),
                  ),
                  child: Text('Sign Up as Runner'),
                ),
              ],
            ),
          ),
        );
      },
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
              // Add more ListTiles for additional options
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFBE1C2D),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return SlideItem(
                    image: images[index],
                    text: texts[index],
                    isLastSlide: index == images.length - 1,
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_currentIndex == images.length - 1)
              ElevatedButton(
                onPressed: () {
                  // Show the sign-up dialog
                  _showSignUpDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 130, 11, 23),
                ),
                child: Text('Get Started'),
              ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => buildDot(index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final String image;
  final dynamic text;
  final bool isLastSlide;

  SlideItem({required this.image, required this.text, required this.isLastSlide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 400,
            width: 450,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          text is String
              ? Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )
              : text, // For RichText
        ],
      ),
    );
  }
}
