import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart'; //add to dependencies

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late CreateAccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Initialize _model before using it
    _model = CreateAccountModel();

    _model.emailAddressController = TextEditingController();
    _model.emailAddressFocusNode = FocusNode();

    _model.fullNameController = TextEditingController();
    _model.fullNameFocusNode = FocusNode();

    _model.passwordController = TextEditingController();
    _model.passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://businessmirror.com.ph/wp-content/uploads/2022/09/Ninja-1024x683.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 569,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x24000000),
                              offset: Offset(0, -1),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 1),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 16, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      top: 20),
                                              child: Text(
                                                'Create Account',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Email Address',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.emailAddressController,
                                            focusNode:
                                                _model.emailAddressFocusNode,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                height: 1.1,
                                              ),
                                              hintText:
                                                  'Enter your email here...',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                fontSize: 14,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .black12, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFBE3947),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 24,
                                                      horizontal: 16),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors
                                                  .black, // Adjust the color as needed
                                              fontSize:
                                                  16, // Adjust the font size as needed
                                            ),
                                            maxLines: null,
                                            cursorColor: Color(0xFFBE3947),
                                            //validator: (value) {
                                            // Replace the validator logic here
                                            //return _model.emailAddressControllerValidator(context)(value);
                                            //},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Full Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.fullNameController,
                                            focusNode: _model.fullNameFocusNode,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                height: 1.1,
                                              ),
                                              hintText:
                                                  'Enter your full name here...',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                fontSize: 14,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .black12, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFBE3947),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 24,
                                                      horizontal: 16),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors
                                                  .black, // Adjust the color as needed
                                              fontSize:
                                                  16, // Adjust the font size as needed
                                            ),
                                            maxLines: null,
                                            cursorColor: Color(0xFFBE3947),
                                            //validator: (value) {
                                            // Replace the validator logic here
                                            //return _model.fullNameControllerValidator(context)(value);
                                            //},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.passwordController,
                                            focusNode: _model.passwordFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.passwordController',
                                              Duration(milliseconds: 2000),
                                              () => setState(() {}),
                                            ),
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                height: 1.1,
                                              ),
                                              hintText:
                                                  'Enter your password here...',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors
                                                    .grey, // Adjust the color as needed
                                                fontSize: 14,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .black12, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFBE3947),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .red, // Adjust the color as needed
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 24,
                                                      horizontal: 16),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors
                                                  .black, // Adjust the color as needed
                                              fontSize:
                                                  16, // Adjust the font size as needed
                                            ),
                                            maxLines: null,
                                            cursorColor: Color(0xFFBE3947),
                                            //validator: (value) {
                                            // Replace the validator logic here
                                            //return _model.fullNameControllerValidator(context)(value);
                                            //},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pushNamed('Login');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFBE1C2D),
                                      padding: EdgeInsets.zero,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Container(
                                      width: 350,
                                      height: 44,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xFFE0E3E7),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.pushNamed(context, 'Login');
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Already have an account? ',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors
                                              .grey, // Adjust the color as needed
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                          color: Color(0xFFBE1C2D),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                    style: TextStyle(
                                      fontFamily:
                                          'Inter', // Adjust the font family as needed
                                      fontSize:
                                          14, // Adjust the font size as needed
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 32),
                child: Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'UTMDASH',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateAccountModel {
  TextEditingController emailAddressController = TextEditingController();
  FocusNode emailAddressFocusNode = FocusNode();

  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  FocusNode unfocusNode = FocusNode();

  // Add other properties and methods as needed

  void dispose() {
    emailAddressController.dispose();
    emailAddressFocusNode.dispose();

    fullNameController.dispose();
    fullNameFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();

    unfocusNode.dispose();

    // Dispose of other resources if necessary
  }
}
