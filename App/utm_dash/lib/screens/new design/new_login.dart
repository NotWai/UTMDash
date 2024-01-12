import 'package:utm_dash/screens/new design/edit_request_runner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class newLogin extends StatefulWidget {
  const newLogin({Key? key}) : super(key: key);

  @override
  _newLoginState createState() => _newLoginState();
}

class _newLoginState extends State<newLogin> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController textController;
  late TextEditingController emailAddressController;
  late FocusNode emailAddressFocusNode;
  late FocusNode textFieldunFocusNode;
  late TextEditingController passwordController;
  late Validator passwordControllerValidator;
  late FocusNode passwordFocusNode;
  late Validator textControllerValidator;
  late bool _passwordVisibility;

  Map<String, AnimationController> animationsMap = {};

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordControllerValidator = Validator();
    _passwordVisibility = false;
    textController = TextEditingController();
    textFieldunFocusNode = FocusNode();
    emailAddressController = TextEditingController();
    emailAddressFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    animationsMap = {
      // define your animations here
    };
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldunFocusNode.dispose();
    emailAddressController.dispose();
    emailAddressFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void animateOnPageLoad() {
    // implement your animation logic here
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
      onTap: () => this.textFieldunFocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(textFieldunFocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xD3000000),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Container(
                width: 1110,
                height: 869,
                decoration: BoxDecoration(
                  color: const Color(0x00FFFFFF),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      'https://businessmirror.com.ph/wp-content/uploads/2022/09/Ninja-1024x683.jpg',
                    ).image,
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -0.5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                      child: Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'UTMDASH',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // or any other FontWeight value
                                ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!.copyWith(
                                        fontWeight: FontWeight.bold, // or any other FontWeight value
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 24),
                                    child: Text(
                                      'Fill out the information below in order to access your account.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: emailAddressController,
                                        focusNode: emailAddressFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          hintText: 'Enter your email here...',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCCCCCC),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFBE3947),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xE65454),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xE65454),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: const Color(0xFFBE3947),
                                        validator: (value) {
                                          if (textControllerValidator.isValid(value ?? '')) {
                                            return null; // Valid input
                                          } else {
                                            return 'Invalid input'; // Invalid input
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: passwordController,
                                        focusNode: passwordFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.password],
                                        obscureText: !_passwordVisibility,
                                        decoration: InputDecoration(
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          hintText: 'Enter your password here...',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCCCCCC),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFBE3947),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xE65454),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xE65454),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => _passwordVisibility =
                                                  !_passwordVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              color: const Color(0xFFD1D1D1),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        cursorColor: const Color(0xFFBE3947),
                                        validator: (value) {
                                          if (passwordControllerValidator.isValid(value ?? '')) {
                                            return null; // Valid input
                                          } else {
                                            return 'Invalid input'; // Invalid input
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //navigateToSignUp(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(screenWidth * 0.4, screenHeight * 0.06),
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                        ),
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      12,
                                      0,
                                      12,
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        //Navigator.of(context).push('CreateAccount');
                                      },
                                      child: RichText(
                                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Don\'t have an account?  ',
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              text: 'Sign Up here',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontFamily: 'Inter',
                                                    color: const Color(0xFFBE1C2D),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            )
                                          ],
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}

