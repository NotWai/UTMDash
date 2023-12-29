import 'package:cloud_firestore/cloud_firestore.dart';

class ParcelObject{
  final String fromName;
  final String runnerID;
  final String arrived;
  final String trackingID;

  ParcelObject({
    required this.fromName,
    required this.runnerID,
    required this.arrived,
    required this.trackingID,
  });
}