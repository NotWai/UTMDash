import 'package:flutter/material.dart';

class HubHomepage extends StatefulWidget {
  const HubHomepage({Key? key}) : super(key: key);

  @override
  State<HubHomepage> createState() => _HubHomepageState();
}

class _HubHomepageState extends State<HubHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 393,
                      height: 237,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBE1C2D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 80, 0, 0),
                                  child: Text(
                                    'NinjaVan Angkasa',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: TextEditingController(),
                                    focusNode: FocusNode(),
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Search...',
                                      labelStyle: TextStyle(fontSize: 16),
                                      hintStyle: TextStyle(fontSize: 16),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.9, 0),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 10),
                    child: Text(
                      'Customer Overdue',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                ListView(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.white60,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.of(context)
                                .pushNamed('HubCustomerDetails');
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '[Customer\'s Name]', //should retrieve data from firebase
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Flexible(
                                    child: Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Text(
                                        '[Number of days passed]', //should retrieve data from firebase
                                        style: TextStyle(
                                          color: Color(0xFFBE1C2D),
                                          fontSize: 16,
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
                    ])
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // ignore: avoid_print
                            print('Button pressed ...');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBE1C2D),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'View Record',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Flexible(
                            child: Align(
                          alignment: const AlignmentDirectional(1, 1),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              // ignore: avoid_print
                              print('IconButton pressed ...');
                            },
                          ),
                        )),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
