import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<String> notifications = [
    "Notification 1: Your package has been delivered.",
    "Notification 2: Upcoming delivery schedule change.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Icon(
                Icons.notifications,
                color: Color.fromARGB(162, 255, 0, 0),
                size: 30,
              ),
          SizedBox(height: 20),
          Text(
            'Notifications',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 0, 0),
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20), // Add margin for the border radius
              decoration: BoxDecoration(
                color: Color.fromARGB(151, 255, 0, 0),
                borderRadius: BorderRadius.circular(15), // Add border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    blurRadius: 20, // Shadow blur radius
                    offset: Offset(0, 5), // Shadow offset
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(notification: notifications[index]);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 40,),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Theme.of(context).primaryColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text('Request A driver Now!'),
            ),
          ),
          SizedBox(height: 90),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          notification,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(60.0); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Customer Page'),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
    );
  }
}
