import 'package:Liveasy/screens/choice_screen.dart';
import 'package:Liveasy/screens/shipper_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/services.dart';
import 'package:Liveasy/screens/transporter_home_screen.dart';
class TransporterLoginScreen extends StatefulWidget {
  @override
  _TransporterLoginScreenState createState() => _TransporterLoginScreenState();
}

class _TransporterLoginScreenState extends State<TransporterLoginScreen> {
  String mobileNum;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user;
  final _codeController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _disableButton = true;

  Future<bool> loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await _auth.signInWithCredential(credential);
        User user = result.user;
        print(user);
        if (user != null) {
          setState(() {
            showProgressHud = false;
          });
          Navigator.pop(context);
          sendUserDetails(userId: user.uid, mobileNum: user.phoneNumber, userType: "transporter");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => TsHomeScreen(
                  user: user,
                ),), (route) => false);
        } else {
          setState(() {
            showProgressHud = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChoiceScreen()));
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChoiceScreen()));
        setState(() {
          showProgressHud = false;
        });
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Type Your Code Here '),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Color(0xFF6264A7),
                    onPressed: () async {setState(() {
                      showProgressHud = true;
                    });
                    try {
                      final code = _codeController.text.trim();
                      AuthCredential credential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);
                      print(credential);
                      var result =
                      await _auth.signInWithCredential(credential);

                      user = result.user;
                      print(user);
                    } catch (e) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChoiceScreen()));
                      throw e;
                    }

                    if (user != null) {
                      setState(() {
                        showProgressHud = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TsHomeScreen(
                                user: user,
                              )));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChoiceScreen()));
                    }
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProgressHud = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: Text('Verify Yourself'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: 25),
            ),
          ),
          backgroundColor:  Color(0xFFF3F2F1),
          key: _scaffoldKey,
          body: ModalProgressHUD(
            inAsyncCall: showProgressHud,
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,  vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/india_flag.png'),
                              // colorFilter: ColorFilter.mode(
                              //     Colors.white.withOpacity(0.8), BlendMode.dstATop),
                            ),
                          ),
                        ),
                        SizedBox(width: 3,),
                        Container(
                          child: Text('+91', style: TextStyle(
                            fontSize: 20,
                          ),),
                        ),
                        SizedBox(width: 4,),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Mobile Number';
                              } else if (value.length != 10) {
                                return 'Please Enter A Valid Mobile Number';
                              } else
                                return null;
                            },
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            onChanged: (value) {
                              mobileNum = value;
                              if (value.length != 10) {
                                setState(() {
                                  _disableButton = true;
                                });
                              } else {
                                setState(() {
                                  _disableButton = false;
                                });
                              }
                            },
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(fontSize: 20)),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Color(0xFF6264A7),

                      onPressed: _disableButton
                          ? null
                          : () {
                        if (!formKey.currentState.validate()) {
                          return;
                        } else {
                          setState(() {
                            showProgressHud = true;
                          });
                          loginUser('+91$mobileNum', (context));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Verify',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white
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
    );
  }
}

