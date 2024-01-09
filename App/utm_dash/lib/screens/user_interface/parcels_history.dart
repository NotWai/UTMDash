import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_parcel_history.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class UserParcelsHistory extends StatefulWidget {
  const UserParcelsHistory({super.key});

  @override
  State<StatefulWidget> createState() => _UserParcelsHistoryState();
}

class _UserParcelsHistoryState extends State<UserParcelsHistory> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context, listen: false);
    final firestoreAccess = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Parcel Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: StreamBuilder<List<ParcelObject>>(
        stream: firestoreAccess.getDeliveredParcels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      
          final parcels = snapshot.data!;
          if (snapshot.data == null || parcels.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'No prevoius parcels \ndelivered...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    
                  ),
                ),
              ),
            );
          }
      
          return ListView.builder(
            itemCount: parcels.length,
            itemBuilder: (context, index) {
              final parcel = parcels[index];
              return CustomParcelListView(
                  firestoreAccess: firestoreAccess, parcel: parcel);
            },
          );
        },
      ),
    );
  }
}
