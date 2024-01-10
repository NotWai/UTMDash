import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_runner_list_tile.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class RunnerHistory extends StatefulWidget {
  const RunnerHistory({super.key});

  @override
  State<StatefulWidget> createState() => _RunnerHistoryState();
}

class _RunnerHistoryState extends State<RunnerHistory> {
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

    final user = Provider.of<UserClass>(context, listen: false);
    final firestoreAccess = DatabaseService(uid: user.uid);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: Text(
          'History',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontFamily: 'Inter',
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 10),
                child: Text(
                  'Completed',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: StreamBuilder(
                  stream: firestoreAccess.geDeliveredRequests,
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
                    return SizedBox(
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
