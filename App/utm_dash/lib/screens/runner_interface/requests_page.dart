import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/screens/runner_interface/accepted_details.dart';
import 'package:utm_dash/components/cust_runner_list_tile.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';
import 'package:utm_dash/screens/notification_page.dart';

class AcceptedRequestsPage extends StatefulWidget {
  const AcceptedRequestsPage({super.key});

  @override
  State<AcceptedRequestsPage> createState() => _AcceptedRequestsPageState();
}

class _AcceptedRequestsPageState extends State<AcceptedRequestsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Accepted Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder(
                stream: firestoreAccess.getAcceptedRequestsByBoth,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final aRequests = snapshot.data!.docs;
                  if (snapshot.data == null || aRequests.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('No accepted requests yet...'),
                      ),
                    );
                  }

                  return Expanded(
                    child: SizedBox(
                      width: 700,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        itemCount: aRequests.length,
                        itemBuilder: (context, index) {
                          final aRequest = aRequests[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AcceptedDetails(
                                      request: aRequest,
                                    ),
                                  ),
                                );
                              },
                              child: MyCustomListTile(
                                request: aRequest,
                                firestoreAccess: firestoreAccess,
                              ));
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
