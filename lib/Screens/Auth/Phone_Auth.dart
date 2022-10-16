import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbite/Config/colors.dart';
import 'package:quickbite/Screens/Home/Home.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verficationId = '';
  bool showLoading = false;
  void signInwithPhoneCredentials(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: showLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: darkishColor,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            // color: Colors.blue,
                            height: 100,
                            child: Text(
                              'Karibu Burger',
                              style: GoogleFonts.barlow(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Column(
                            children: [
                              TextField(
                                style: GoogleFonts.barlow(color: Colors.white),
                                controller: phoneController,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                autocorrect: false,
                                cursorColor: Colors.white,
                                cursorRadius: Radius.circular(4.0),
                                // cursorWidth: 15,
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  hintStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    showLoading = true;
                                  });
                                  String fieldText=phoneController.text;
                                  if (fieldText[0]=='0') {
                                    fieldText=fieldText.substring(1);
                                    fieldText='+254'+fieldText;
                                    print(fieldText);
                                  }

                                
                                  await _auth.verifyPhoneNumber(
                                      phoneNumber: fieldText,
                                      verificationCompleted:
                                          (phoneAuthCredential) async {
                                        setState(() {
                                          showLoading = false;
                                        });
                                        // signInwithPhoneCredentials(phoneAuthCredential);
                                      },
                                      verificationFailed:
                                          (verificationFailed) async {
                                        print(verificationFailed.message.toString());
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(verificationFailed
                                                    .message
                                                    .toString())));
                                        setState(() {
                                          showLoading = false;
                                        });
                                      },
                                      codeSent: (verificationId,
                                          resendingToken) async {
                                        setState(() {
                                          showLoading = false;
                                          currentState = MobileVerificationState
                                              .SHOW_OTP_FORM_STATE;
                                          verficationId = verificationId;
                                        });
                                      },
                                      codeAutoRetrievalTimeout:
                                          (verficationId) async {});
                                },
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.barlow(
                                    color: Colors.black,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: darkishColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // color: Colors.blue,
                            height: 100,
                            child: Text(
                              'A verfication Code was sent to the number you provided.If you did not recive it please go back and try again',
                              style: GoogleFonts.barlow(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextField(
                            style: GoogleFonts.barlow(color: Colors.white),
                            controller: otpController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            autocorrect: false,
                            cursorColor: Colors.white,
                            cursorRadius: Radius.circular(4.0),
                            // cursorWidth: 15,
                            decoration: InputDecoration(
                              hintText: 'Enter Verificaton Code',
                              hintStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verficationId,
                                      smsCode: otpController.text);
                              //signing in the user to firebase
                              FocusScope.of(context).requestFocus(FocusNode());
                              try {
                                signInwithPhoneCredentials(phoneAuthCredential);
                                Navigator.of(context).pop;
                              } catch (e) {
                                print(e.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              }
                            },
                            child: Text(
                              'Verify',
                              style: GoogleFonts.barlow(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
