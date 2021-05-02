import 'package:flutter/material.dart';
import 'package:Liveasy/screens/transporter_found_loads.dart';

var controller1 = TextEditingController();
var controller2 = TextEditingController();
String loadingPoint = '';
String unloadingPoint = '';
//TODO: put this key into .env file!!!!
//never ever put any secret keys in your code !!!
//Always define them in .env file
String apikey = 'AIzaSyCI8bvNwE05B7Cp03Rvc-QsMX9QjY-EsS4';

class TsFindLoadScreen extends StatefulWidget {
  @override
  _TsFindLoadScreenState createState() => _TsFindLoadScreenState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _TsFindLoadScreenState extends State<TsFindLoadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFF3F2F1),
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: 25),
            ),
            title: Text(
              'Find Load',
              textAlign: TextAlign.center,
            ),
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus.context).save();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 0),
                      child: Container(
                        color: Color(0xFFF3F2F1),
                        child: ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          children: [
                            Container(
                              height: 72,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: controller1,
                                      // onFieldSubmitted: (String value) {
                                      //   loadingPoint = value;
                                      // },
                                      onChanged: (newValue) {
                                        loadingPoint = newValue.trim();
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Loading Point',
                                        hintStyle: TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                      // validator: (String value) {
                                      //   if (value.trim().isEmpty) {
                                      //     return 'Loading Point is Required';
                                      //   } else
                                      //     return null;
                                      // },
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            loadingPoint = '';
                                            controller1 =
                                                TextEditingController(text: '');
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 25,
                                          color: Colors.black26,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 72,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller2,
                                      autofocus: true,
                                      onChanged: (newValue) {
                                        unloadingPoint = newValue.trim();
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Unloading Point',
                                        hintStyle: TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                      // validator: (String value) {
                                      //   if (value.trim().isEmpty) {
                                      //     return 'Unloading Point is Required';
                                      //   } else
                                      //     return null;
                                      // },
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            unloadingPoint = '';
                                            controller2 =
                                                TextEditingController(text: '');
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 25,
                                          color: Colors.black26,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              child: FlatButton(
                                onPressed: () async {
                                  // if (!formKey.currentState.validate()) {
                                  //   return;
                                  // }
                                  if ((loadingPoint == null ||
                                          loadingPoint.trim() == '') &&
                                      (unloadingPoint == null ||
                                          unloadingPoint.trim() == '')) {
                                    FocusScope.of(context).unfocus();
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialogBox());
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TsFoundLoadsScreen(
                                                  searchedLoadingPoint:
                                                      loadingPoint,
                                                  searchedUnloadingPoint:
                                                      unloadingPoint,
                                                )));
                                  }
                                },
                                color: Color(0xFF043979),
                                child: Text(
                                  'Find',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
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
    );
  }
}

class AlertDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF3F2F1),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Loading Point And Unloading Point',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            Text(
              'Both Cannot Be Empty',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            Text(
              'Please Enter Atleast One',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            color: Color(0xFF043979),
            child: Center(
              child: Text(
                'ReEnter',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
