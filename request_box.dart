//!------------------------------------------------------------------------

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'request_details.dart';

class RequestBox extends StatelessWidget {
  final Map<String, String> data;
  final BuildContext context;
  final ValueNotifier<bool> isAccepted;

  RequestBox(this.data, this.context, this.isAccepted);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDetailsScreen(data, isAccepted),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 27, top: 18, bottom: 0, right: 25),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: Container(
            height: 90,
            width: 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 214, 214),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ValueListenableBuilder(
                        valueListenable: isAccepted,
                        builder: (context, value, child) {
                          if (value) {
                            return Icon(Icons.check_circle,
                                color: Colors.green);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                  Row(
                    children: <Widget>[                
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text(
                        data['destination']!,
                        style: TextStyle(
                            fontFamily: 'Grotesco',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.calendar_today, size: 17),
                      ),
                      SizedBox(width: 11),
                      Text(
                        data['date']!,
                        style: TextStyle(
                            fontFamily: 'Grotesco',
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      data['fee']!,
                      style: TextStyle(
                        fontFamily: 'Grotesco',
                        fontSize: 15,
                        color: Color.fromARGB(255, 119, 53, 26),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
