import 'package:flutter/material.dart';
import 'package:utm_dash/profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();

  void dispose() {}
}

class _EditProfileState extends State<EditProfile> {
  late EditProfile _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        ),
        title: const Text('Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white,
            )),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'Upload Profile Picture',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              /*onTap: () async {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: true,
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(() => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                              height: m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(
                                            m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    _model.isDataUploading = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() {
                                      _model.uploadedLocalFile =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl =
                                          downloadUrls.first;
                                    });
                                  } else {
                                    setState(() {});
                                    return;
                                  }
                                }
                              },*/
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, 0.00),
                                  child: /*AuthUserStreamWidget(
                                    builder: (context) =>*/
                                      Container(
                                    width: 100,
                                    height: 100,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                          child: TextFormField(
                              //controller: _model.textController1,
                              //focusNode: _model.textFieldFocusNode1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.person_rounded,
                                ),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              )
                              //validator: _model.textController1Validator
                              //.asValidator(context),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                          child: TextFormField(
                              //controller: _model.textController2,
                              //focusNode: _model.textFieldFocusNode2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.email_rounded,
                                ),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              )
                              //validator: _model.textController2Validator
                              //.asValidator(context),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                          child: /*AuthUserStreamWidget(
                            builder: (context) =>*/
                              TextFormField(
                                  //controller: _model.textController3,
                                  //focusNode: _model.textFieldFocusNode3,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.phone_rounded,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )
                                  //validator: _model.textController3Validator
                                  //.asValidator(context),
                                  ),
                        ),
                      ),
                      //),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                          child: /*AuthUserStreamWidget(
                            builder: (context) =>*/
                              TextFormField(
                                  //controller: _model.textController4,
                                  //focusNode: _model.textFieldFocusNode4,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.school_rounded,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )
                                  //validator: _model.textController4Validator
                                  //.asValidator(context),
                                  ),
                        ),
                      ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCC2C2C),
                    padding: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                child: Container(
                  width: 270,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
