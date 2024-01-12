import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditRequestRunner extends StatefulWidget {
  const EditRequestRunner({Key? key}) : super(key: key);

  @override
  _EditRequestRunnerState createState() => _EditRequestRunnerState();
}

DateTime getCurrentTimestamp() {
  return DateTime.now();
}

class _EditRequestRunnerState extends State<EditRequestRunner> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  Widget wrapInMaterialDatePickerTheme(
    BuildContext context,
    Widget child, {
    Color headerBackgroundColor = const Color(0xFFBE3947),
    Color headerForegroundColor = Colors.black,
    required TextStyle headerTextStyle,
    Color textColor = Colors.black,
    Color backgroundColor = const Color(0xFFBE3947),
  }) {
    return wrapInMaterialDatePickerTheme(
      context,
      child,
      headerBackgroundColor: const Color(0xFFBE3947),
      headerForegroundColor: Colors.black,
      headerTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontFamily: 'Readex Pro',
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
      textColor: textColor,
      backgroundColor: const Color(0xFFBE3947),
    );
  }

  String valueOrDefault<T>(T value, T defaultValue) {
    return value != null ? value.toString() : defaultValue.toString();
  }

  String dateTimeFormat(String format, DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat(format).format(dateTime);
    } else {
      return 'Select Time'; // or any default value you want to return
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController textController;

  late FocusNode textFieldFocusNode;
  late TextEditingController textController3;
  late Validator textControllerValidator;
  late TextEditingController phoneNumTextFieldController1;
  late TextEditingController phoneNumTextFieldController2;
  late TextEditingController phoneNumTextFieldController3;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
    phoneNumTextFieldController1 = TextEditingController();
    phoneNumTextFieldController2 = TextEditingController();
    phoneNumTextFieldController3 = TextEditingController();
    textController3 = TextEditingController();
    textControllerValidator = Validator();
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => this.textFieldFocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(textFieldFocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
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
          title: Text(
            'Request Runner',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 5),
                            child: Text(
                              'Name',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: textController,
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: 'Name (Autofill)',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE0E3E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: const Color(0xFFBE3947),
                          validator: (value) {
                            if (textControllerValidator.isValid(value ?? '')) {
                              return null; // Valid input
                            } else {
                              return 'Invalid input'; // Invalid input
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 5),
                            child: Text(
                              'Phone Number',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: phoneNumTextFieldController1,
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: 'Phone Number (Autofill)',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE0E3E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: const Color(0xFFBE3947),
                          validator: (value) {
                            if (textControllerValidator.isValid(value ?? '')) {
                              return null; // Valid input
                            } else {
                              return 'Invalid input'; // Invalid input
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 5),
                              child: Text(
                                'Tracking Number',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: textController3,
                                    focusNode: textFieldFocusNode,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      hintText: 'Tracking Number',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xE65454),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xE65454),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    cursorColor: const Color(0xFFBE3947),
                                    validator: (value) {
                                      if (textControllerValidator
                                          .isValid(value ?? '')) {
                                        return null; // Valid input
                                      } else {
                                        return 'Invalid input'; // Invalid input
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBE1C2D),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                  color: const Color(0xFFBE1C2D),
                                  icon: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Date Widget
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 5),
                                  child: Text(
                                    'Date',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey,
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
                                              10, 0, 0, 0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                              'd/M/y', DateTime.now()),
                                          'Choose Arrived Time',
                                        ),
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
                                              color: Colors.grey,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(5),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xE0E3E7),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  iconSize: 46,
                                                  color: Colors.black,
                                                  icon: const Icon(
                                                    Icons.calendar_month,
                                                    size: 24,
                                                  ),
                                                  onPressed: () async {
                                                    final _datePicked1Date =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          getCurrentTimestamp(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2050),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              ThemeData.light()
                                                                  .copyWith(
                                                            primaryColor:
                                                                const Color(
                                                                    0xFFBE3947),
                                                            colorScheme:
                                                                const ColorScheme
                                                                    .light(
                                                              primary: Color(
                                                                  0xFFBE3947),
                                                            ),
                                                            buttonTheme:
                                                                const ButtonThemeData(
                                                                    textTheme:
                                                                        ButtonTextTheme
                                                                            .primary),
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    if (_datePicked1Date !=
                                                        null) {
                                                      safeSetState(() {
                                                        datePicked1 = DateTime(
                                                          _datePicked1Date.year,
                                                          _datePicked1Date
                                                              .month,
                                                          _datePicked1Date.day,
                                                        );
                                                      });
                                                    }
                                                  },
                                                ),
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
                        // Time Widget
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 5),
                                child: Text(
                                  'Time',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey,
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
                                            10, 0, 0, 0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat('Hm', datePicked2),
                                        'Choose Dateline',
                                      ),
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
                                            color: Colors.grey,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(5),
                                            ),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      const Color(0x00FFFFFF),
                                                  width: 1,
                                                ),
                                              ),
                                              child: IconButton(
                                                iconSize: 46,
                                                color: Colors.black,
                                                icon: const Icon(
                                                  Icons.access_time_outlined,
                                                  size: 24,
                                                ),
                                                onPressed: () async {
                                                  final _datePicked2Date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        getCurrentTimestamp(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2050),
                                                  );
                                                  if (_datePicked2Date !=
                                                      null) {
                                                    safeSetState(() {
                                                      datePicked2 = DateTime(
                                                        _datePicked2Date.year,
                                                        _datePicked2Date.month,
                                                        _datePicked2Date.day,
                                                      );
                                                    });
                                                  }
                                                },
                                              ),
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
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 5),
                            child: Text(
                              'Location',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: phoneNumTextFieldController2,
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: 'College, Block',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE0E3E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: const Color(0xFFBE3947),
                          validator: (value) {
                            if (textControllerValidator.isValid(value ?? '')) {
                              return null; // Valid input
                            } else {
                              return 'Invalid input'; // Invalid input
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 5),
                            child: Text(
                              'Note to Runner (if any)',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: phoneNumTextFieldController3,
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: 'Note here...',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE0E3E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xE65454),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: const Color(0xFFBE3947),
                          validator: (value) {
                            if (textControllerValidator.isValid(value ?? '')) {
                              return null; // Valid input
                            } else {
                              return 'Invalid input'; // Invalid input
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showDoneDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(screenWidth * 0.3, screenHeight * 0.07),
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 0, 24, 0),
                              backgroundColor: const Color(0xFFBE1C2D),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                  ),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'Inter',
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
          ],
        ),
      ),
    );
  }
}

void _showDoneDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Done'),
        content: Text('Request updated.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the second dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class Validator {
  bool isValid(String value) {
    // Implement your validation logic here
    // For example, checking if the value is not empty
    return value.isNotEmpty;
  }
}
