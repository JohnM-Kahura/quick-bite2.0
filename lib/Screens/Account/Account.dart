import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickbite/Screens/Auth/Phone_Auth.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  Widget build(BuildContext context) {
    _user = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          actions: [
            TextButton(
              onPressed: () async {
              await _auth.signOut();
                // Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authentication()));
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: Card(
            
            child: Container(
              height:150,
              width: MediaQuery.of(context).size.width,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   'PhoneNumber',
                  ),
                  Container(
                    margin: EdgeInsets.only(top :20),
                    child: Text(
                      _user!.phoneNumber.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
