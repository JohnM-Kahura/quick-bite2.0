import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbite/Config/colors.dart';
import 'package:quickbite/Screens/Account/Account.dart';
import 'package:flutter/material.dart';
import 'package:quickbite/Screens/Auth/Phone_Auth.dart';
import 'package:quickbite/Screens/Home/config.dart';
import 'package:quickbite/Widgets/UserNavDrawer.dart';
import 'package:quickbite/Widgets/customItem.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool show_log_out = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Home',
            style: GoogleFonts.barlow(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: darkishColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                show_log_out = !show_log_out;
              });
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      drawer: UserNavDrawer(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: itemsOnSale.length,
            itemBuilder: (BuildContext context, int index) {
              return customItemView(
                  context, itemsOnSale[index], itemsImages[index]);
            },
          ),
          if (show_log_out)
            Positioned(
                top: 0,
                right: 0,
                child: Card(
                  margin: EdgeInsets.only(top: 0),
                  child: Container(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Account()));
                            },
                            child: Text('Profile')),
                        TextButton(
                            onPressed: () {
                              _auth.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Authentication()));
                              Navigator.of(context).pop();
                            },
                            child: Text('LogOut')),
                  ],
               ),
             ),
          )),
        ],
      ),
    );
  }
}
