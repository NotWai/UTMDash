import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController textController;
  late FocusNode textFieldFocusNode;
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
    pageViewController = PageController();
  }

  @override
  void dispose() {
    // Dispose of any resources if needed.
    textController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              //width: 393,
              height: 313,
              decoration: BoxDecoration(
                color: Color(0xFFBE1C2D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 50, 0, 0),
                      child: Text(
                        'Track Parcel',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 10),
                      child: Text(
                        'Enter parcel number',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: textController,
                      focusNode: textFieldFocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        hintText: 'tracking number',
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Color(0xFFACACAC),
                        ),
                      ),
                      cursorColor: Color(0xFFBE1C2D),
                      style: Theme.of(context).textTheme.bodyText2!.merge(
                            TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 25, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.06,
                        alignment: Alignment.center,
                        child: Text(
                          'Track Parcel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 40),
                      child: PageView(
                        controller: pageViewController as PageController? ??
                            PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/Runner_ads.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/NinjaVan_ads.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
                        child: smooth_page_indicator.SmoothPageIndicator(
                          controller: pageViewController as PageController? ??
                              PageController(initialPage: 0),
                          count: 2,
                          axisDirection: Axis.horizontal,
                          onDotClicked: (int i) async {
                            await pageViewController.animateToPage(
                              i,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          effect: smooth_page_indicator.ExpandingDotsEffect(
                            expansionFactor: 3,
                            spacing: 8,
                            radius: 16,
                            dotWidth: 16,
                            dotHeight: 8,
                            dotColor: Color(0xFFACACAC),
                            activeDotColor: Colors.black,
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 5, 0, 10),
                child: Text(
                  'Important',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
              child: Container(
                width: 350,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Runner Service Rate',
                            style: TextStyle(
                              color: Color(0xFFBE1C2D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Parcel Fee / each - RM1.00'),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Runner Service Fee - RM2.00'),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Total = Parcel Fee + Runner Service Fee'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
              child: Container(
                width: 393,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'NinjaVan Angkasa Service',
                                  style: TextStyle(
                                    color: Color(0xFFBE1C2D),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Text('Shipping Service Available'),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Text(
                                  'Location: Arked Angkasa, KTDI, UTM Skudai, 80990 Johor Bahru, Johor'),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Parcel_Details.png',
                          width: 300,
                          height: 167,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
