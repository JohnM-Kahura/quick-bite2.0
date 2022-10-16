import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbite/Config/colors.dart';
import 'package:quickbite/Screens/Account/Account.dart';
import 'package:quickbite/Screens/DashBoard/DashBoard.dart';
import 'package:quickbite/Screens/Settings/Settings.dart';

class UserNavDrawer extends StatelessWidget {
  const UserNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: darkishColor,
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: MediaQuery.of(context).size.width - 80,
              child: Image(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                image: AssetImage('images/CollageLogo.jpg'),
              ),
            ),
            ListTile(
                tileColor: Colors.white,
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Account(),
                    ),
                  );
                }),
//TODO: add a settings page here
            ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: Text(
                  'DashBoard',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DashBoard(),
                    ),
                  );
                }),
            SizedBox(
              height: 200,
            ),
            Icon(Icons.warning,color: Colors.red,size: 40,),
            Container(
              child: Text(
                'Fast Delivery!',
                style: GoogleFonts.barlow(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
