// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'show_pop.dart';

class RequestDetailsScreen extends StatelessWidget {
  final Map<String, String> requestData;

  //!------------
  final ValueNotifier<bool> isAccepted;

  RequestDetailsScreen(this.requestData, this.isAccepted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 194, 94, 94),
        title: Text('Request Details'),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 27, top: 18, bottom: 0, right: 25),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 10,
            child: Container(
              height: 260,
              width: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 214, 214),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: ${requestData['name']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Tracking No: ${requestData['last_tracking_num']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Address: ${requestData['destination']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Date/Time: ${requestData['date']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Earnings: ${requestData['fee']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 182, 52, 35),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, bottom: 7, left: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              showAccept(context, isAccepted);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 194, 94, 94),
                              fixedSize: Size(100, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, bottom: 7, right: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              showReject(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 233, 170, 170),
                              fixedSize: Size(100, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(255, 194, 94, 94),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
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
