// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'viewHubPage.dart';
import 'uploadPic.dart';
import 'parcelHubProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class editParcelHubProfile extends StatefulWidget {
  editParcelHubProfile({super.key});

  @override
  _editParcelHubProfileState createState() => _editParcelHubProfileState();
}

class _editParcelHubProfileState extends State<editParcelHubProfile> {
  late Color myColor = Color(0xFFBE1C2D);
  late Color backColor = Color.fromARGB(255, 226, 220, 220);
  late Size mediaSize;
  int currentindex = 1;

  final picker = ImagePicker();
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: myColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth
                .instance.currentUser?.uid) // Replace with the actual user ID
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding:
                  const EdgeInsets.only(left: 23, top: 0, bottom: 0, right: 23),
              child: Material(
                elevation: 0,
                color: backColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      child: Stack(children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    "https://th.bing.com/th?id=OIP.w2McZSq-EYWxh02iSvC3xwHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"),
                              ),
                        Positioned(
                          bottom: -8,
                          left: 82,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 83, 79, 79)),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Transform.translate(
                              offset: Offset(10, -10),
                              child: Container(
                                height: 65,
                                child: TextField(
                                    decoration: InputDecoration(
                                  hintText:  '${data['Fullname']}',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding:
                                      EdgeInsets.only(top: 35, left: 12),
                                  border: InputBorder.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 83, 79, 79)),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Transform.translate(
                              offset: Offset(10, -10),
                              child: Container(
                                height: 65,
                                child: TextField(
                                    decoration: InputDecoration(
                                  hintText:  '${data['Email']}',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding:
                                      EdgeInsets.only(top: 35, left: 12),
                                  border: InputBorder.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contact Number',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 83, 79, 79)),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Transform.translate(
                              offset: Offset(10, -10),
                              child: Container(
                                height: 65,
                                child: TextField(
                                    decoration: InputDecoration(
                                  hintText:  '${data['Phone']}',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding:
                                      EdgeInsets.only(top: 35, left: 12),
                                  border: InputBorder.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Address',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 83, 79, 79)),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Transform.translate(
                              offset: Offset(10, -10),
                              child: Container(
                                height: 65,
                                child: TextField(
                                    decoration: InputDecoration(
                                  hintText: 'Enter address',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding:
                                      EdgeInsets.only(top: 35, left: 12),
                                  border: InputBorder.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 83, 79, 79)),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Transform.translate(
                              offset: Offset(10, -10),
                              child: Container(
                                height: 65,
                                child: TextField(
                                    decoration: InputDecoration(
                                  hintText:  '*' * data['Password'].length,
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding:
                                      EdgeInsets.only(top: 35, left: 12),
                                  border: InputBorder.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Container(
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              iconSize: MaterialStateProperty.all(40),
                              backgroundColor:
                                  MaterialStateProperty.all(myColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewHubPage()),
                              );
                            },
                            child: Text('Save Profile',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 201, 193, 193),
        type: BottomNavigationBarType.fixed,
        fixedColor: myColor,
        iconSize: 30,
        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
            if (currentindex == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => parcelHubProfilePage()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewHubPage()));
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 201, 193, 193),
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 201, 193, 193),
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
