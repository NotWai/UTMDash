// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_runner_list_tile.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/screens/runner_interface/runner_acccpet_page.dart';
import 'package:utm_dash/services/f_database.dart';

class RunnerHomepage extends StatefulWidget {
  const RunnerHomepage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RunnerHomepageState();
}

class _RunnerHomepageState extends State<RunnerHomepage> {
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontFamily: 'Inter',
                fontSize: 20,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 10),
                      child: Text(
                        'Requests pending customer approval',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: firestoreAccess.getAcceptedRequestsByRunner,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final requests = snapshot.data!.docs;
                      if (snapshot.data == null || requests.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(25),
                          child: Text('No requests yet...'),
                        );
                      }
                      return Expanded(
                        child: SizedBox(
                          width: 700,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              final request = requests[index];
                              return MyCustomListTile(
                                request: request,
                                firestoreAccess: firestoreAccess,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 10),
                    child: Text(
                      'Available Requests',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                      return const Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('No requests yet...'),
                      );
                    }

                    return Expanded(
                      child: SizedBox(
                        width: 700,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RunnerAccept(request: request),
                                  ),
                                );
                              },
                              child: MyCustomListTile(
                                request: request,
                                firestoreAccess: firestoreAccess,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
