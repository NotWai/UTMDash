import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HubAddParcel extends StatefulWidget {
  const HubAddParcel({super.key});

  @override
  State<HubAddParcel> createState() => _HubAddParcelState();
}

class ParcelDetails {
  String name = '';
  String phoneNumber = '';
  String trackingNumber = '';
  DateTime? arrivedDate;
  DateTime? dateline;
}

class _HubAddParcelState extends State<HubAddParcel> {
  final ParcelDetails _parcelDetails = ParcelDetails();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: const [],
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                        'This is a form to add your customer\'s parcel details.',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: TextFormField(
                      //controller: _model.nameTextFieldController,
                      focusNode: FocusNode(),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: 'Name',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFBE3947),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: const Color(0xFFBE3947),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null; // Return null if the input is valid
                      },
                      onChanged: (value) {
                        setState(() {
                          _parcelDetails.name = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: TextFormField(
                      //controller: _model.phoneNumTextFieldController,
                      focusNode: FocusNode(),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: 'Phone Number',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFBE3947),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: const Color(0xFFBE3947),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null; // Return null if the input is valid
                      },
                      onChanged: (value) {
                        setState(() {
                          _parcelDetails.phoneNumber = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: TextFormField(
                      //controller: _model.trackingNumTextFieldController,
                      focusNode: FocusNode(),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: 'Tracking Number',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFBE3947),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: const Color(0xFFBE3947),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a valid name';
                        }
                        return null; // Return null if the input is valid
                      },
                      onChanged: (value) {
                        setState(() {
                          _parcelDetails.trackingNumber = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: Text(
                                  'Arrived Time',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE0E3E7),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                    child: Text(
                                      datePicked1 != null
                                          ? DateFormat('d/M H:mm')
                                              .format(datePicked1!)
                                          : 'No Date Picked', // Replace with your desired default value
                                      semanticsLabel: 'Choose Arrived Time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: 40,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE0E3E7),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(5),
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE0E3E7),
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1, 0),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_month_rounded,
                                                color: Color(0xFFACACAC),
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                final datePicked1Date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2050),
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        primaryColor: const Color(
                                                            0xFFBE3947), // Header background color
                                                        hintColor: Colors
                                                            .white, // Header text color
                                                        textTheme:
                                                            const TextTheme(
                                                          titleLarge: TextStyle(
                                                            fontSize: 32,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .white, // Header text color
                                                          ),
                                                          titleMedium:
                                                              TextStyle(
                                                            color: Colors
                                                                .black, // Picker text color
                                                          ),
                                                          bodyLarge: TextStyle(
                                                            color: Colors
                                                                .black, // Action button text color
                                                          ),
                                                        ),
                                                        colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                          primary: Color(
                                                              0xFFBE3947), // Selected date background color
                                                          onPrimary: Colors
                                                              .white, // Selected date text color
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );

                                                if (datePicked1Date != null) {
                                                  setState(() {
                                                    datePicked1 = DateTime(
                                                      datePicked1Date.year,
                                                      datePicked1Date.month,
                                                      datePicked1Date.day,
                                                    );
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: Text(
                                  'Dateline',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE0E3E7),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                    child: Text(
                                      datePicked2 != null
                                          ? DateFormat('d/M H:mm')
                                              .format(datePicked2!)
                                          : 'No Date Picked', // Replace with your desired default value
                                      semanticsLabel: 'Choose Dateline',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: 40,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE0E3E7),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(5),
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE0E3E7),
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1, 0),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_month_rounded,
                                                color: Color(0xFFACACAC),
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                final datePicked2Date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2050),
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        primaryColor: const Color(
                                                            0xFFBE3947), // Header background color
                                                        hintColor: Colors
                                                            .white, // Header text color
                                                        textTheme:
                                                            const TextTheme(
                                                          titleLarge: TextStyle(
                                                            fontSize: 32,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .white, // Header text color
                                                          ),
                                                          titleMedium:
                                                              TextStyle(
                                                            color: Colors
                                                                .black, // Picker text color
                                                          ),
                                                          bodyLarge: TextStyle(
                                                            color: Colors
                                                                .black, // Action button text color
                                                          ),
                                                        ),
                                                        colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                          primary: Color(
                                                              0xFFBE3947), // Selected date background color
                                                          onPrimary: Colors
                                                              .white, // Selected date text color
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );

                                                if (datePicked2Date != null) {
                                                  setState(() {
                                                    datePicked2 = DateTime(
                                                      datePicked2Date.year,
                                                      datePicked2Date.month,
                                                      datePicked2Date.day,
                                                    );
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // ignore: avoid_print
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFBE1C2D),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Center(
                          child: Text(
                            'Add',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
