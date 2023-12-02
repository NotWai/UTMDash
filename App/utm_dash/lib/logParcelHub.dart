

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class logDetails extends StatelessWidget {
  final Map<String, String> data;
  late Color myColor = Color(0xFFBE1C2D);

  logDetails(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, top: 18, bottom: 0, right: 25),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: Container(
          height: 90,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(width: 8),
                      Text(
                        data['time']!,
                        style: TextStyle(
                          fontFamily: 'Grotesco',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.phone, size: 17),
                      ),
                      SizedBox(width: 11),
                      Text(
                        data['contact_no']!,
                        style: TextStyle(
                          fontFamily: 'Grotesco',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.gps_fixed, size: 17),
                      ),
                      SizedBox(width: 11),
                      Text(
                        data['last_tracking_num']!,
                        style: TextStyle(
                          fontFamily: 'Grotesco',
                          fontSize: 15,
                          color: Color.fromARGB(255, 119, 53, 26),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
