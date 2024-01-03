import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_list_tile.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';
import 'package:utm_dash/viewCustomerPage.dart';

class RunnerHomePage extends StatefulWidget {
  const RunnerHomePage({super.key});

  @override
  State<RunnerHomePage> createState() => _RunnerHomePageState();
}

class _RunnerHomePageState extends State<RunnerHomePage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Runner Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              StreamBuilder(
                stream: firestoreAccess.getNewRequestsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final requests = snapshot.data!.docs;
                  if (snapshot.data == null || requests.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('No requests yet...'),
                      ),
                    );
                  }
                  return Expanded(
                    child: SizedBox(
                      width: 700,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final QueryDocumentSnapshot request = requests[index];
                          return MyCustomListTile(request: request, firestoreAccess: firestoreAccess, accepted: false,);
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
