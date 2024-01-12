// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_snackbar.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class UpdateDeliveryPage extends StatefulWidget {
  final ParcelObject parcel;
  const UpdateDeliveryPage({
    Key? key,
    required this.parcel,
  }) : super(key: key);

  @override
  State<UpdateDeliveryPage> createState() => _UpdateDeliveryPageState();
}

class _UpdateDeliveryPageState extends State<UpdateDeliveryPage> {
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  DateTime? selectedDateTime;

  Future<void> _selectDateAndTime(
      BuildContext context, DatabaseService firestoreAccess) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Delivery'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<UserData>(
                  future: firestoreAccess.userDataStream.first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    UserData userData = snapshot.data!;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${widget.parcel.fromName}',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text('Phone Number: ${userData.phoneNumber}',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text('Tracking ID: ${widget.parcel.trackingID}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Time of Delivery:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>
                          _selectDateAndTime(context, firestoreAccess),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade400),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(5.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: selectedDateTime != null
                            ? Text(
                                'Selected Date and Time: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime!)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              )
                            : const Text(
                                'Select Date and Time',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Delivery Address',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a delivery address' : null,
                    controller: _deliveryAddressController,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Notes (Optional)',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    controller: _notesController,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: [Colors.red.shade700, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            if (selectedDateTime == null) {
                              AppSnackBar.showSnackBar(
                                  context, 'Please select a date and time');
                            } else {
                              dynamic result =
                                  await firestoreAccess.updateDeliveryRequest(
                                      widget.parcel.trackingID,
                                      _deliveryAddressController.text,
                                      _notesController.text,
                                      selectedDateTime!);
                              if (result == null) {
                                AppSnackBar.showSnackBar(context,
                                    'Delivery request has been updated',
                                    backgroundColor: Colors.green);
                                Navigator.pop(context);
                              } else {
                                AppSnackBar.showSnackBar(context, result);
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Update Request',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: [Colors.red.shade700, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic result = await firestoreAccess
                              .deleteDeliveryRequest(widget.parcel.trackingID);
                          if (result == null) {
                            AppSnackBar.showSnackBar(
                                context, 'Delivery request has been deleted',
                                backgroundColor: Colors.green);
                            Navigator.pop(context);
                          } else {
                            AppSnackBar.showSnackBar(context, result);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Delete the request',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
