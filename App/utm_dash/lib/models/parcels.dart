class ParcelObject{
  final String fromName;
  final String runnerID;
  final String arrived;
  final String trackingID;
  final String deadline;
  final String status;
  final String receiverID;
  final String docID;
  

  ParcelObject({
    required this.docID,
    required this.fromName,
    required this.runnerID,
    required this.arrived,
    required this.trackingID,
    required this.deadline,
    required this.receiverID,
    required this.status,
  });
}