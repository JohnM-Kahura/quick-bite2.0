import 'package:flutter/material.dart';
import 'package:quickbite/Screens/DashBoard/ActiveOrders.dart';
import 'package:quickbite/Screens/DashBoard/Purchases.dart';

import 'package:quickbite/Config/colors.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ActiveOrders(),
    Purchases(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:darkishColor,
        title: Text('DashBoard'),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkishColor,
        currentIndex: _selectedIndex,
       
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_pizza,
              color: Colors.grey,
            ),
            label: 'Orders',
            
            // title: Text('Active'),
            activeIcon: Icon(
              Icons.local_pizza,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
           
            icon: Icon(
              Icons.history,
              color: Colors.grey ,
            ),
            label: 'Purchases',
            activeIcon: Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
         onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
