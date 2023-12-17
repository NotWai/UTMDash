import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utm_dash/models/IntroPageModel.dart';

class IntroPageWidget extends StatefulWidget {
  const IntroPageWidget({Key? key}) : super(key: key);

  @override
  _IntroPageWidgetState createState() => _IntroPageWidgetState();
}

class _IntroPageWidgetState extends State<IntroPageWidget> {
  late IntroPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _model = createModel(context, () => IntroPageModel());
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFBE1C2D),
            body: SafeArea(
                top: true,
                child: Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Container(
                    width: double.infinity,
                    height: 914,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: PageView(
                            controller: _model.pageViewController ??=
                                PageController(initialPage: 0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(''),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
