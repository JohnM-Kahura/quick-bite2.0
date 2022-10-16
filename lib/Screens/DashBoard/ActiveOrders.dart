import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbite/Config/colors.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({Key? key}) : super(key: key);

  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List orders = [];
  bool isAdmin = false;

  Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
      .collection('Phone')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .collection('Orders')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _ordersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: (CircularProgressIndicator()));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  // String documentSnapshot=snapshot.data!.docs.toString();
                
                  String id = snapshot.data!.docs[index].id;
                  
                  
                  String burger =snapshot.data!.docs[index]['Burger'];
                  String kebab = snapshot.data!.docs[index]['Kebab'];
                  String smokie = snapshot.data!.docs[index]['Smokie'];
                  String smocha = snapshot.data!.docs[index]['Smocha'];
                  String status = snapshot.data!.docs[index]['Status'];
                 
                 

                  return Card(
                    child: Container(
                      child: Column(
                        children: [
                       
                         
                       

                          // Row(children: [
                          //   Container(
                          //     child: Text('Name:', style: dashboardStyle),
                          //   ),
                          //   Container(
                          //     child: Text('John', style: dashboardStyle),
                          //   ),
                          // ]),
                          Row(children: [
                            Container(
                              child: Text('Phone:', style: dashboardStyle),
                            ),
                            Container(
                              child: Text(
                                  FirebaseAuth.instance.currentUser!.phoneNumber
                                      .toString(),
                                  style: dashboardStyle),
                            ),
                          ]),
                          Row(children: [
                            if(burger!='')
                            Text('Burger:', style: dashboardStyle),
                            if(burger!='')
                            Text(burger, style: dashboardNumberStyle),
                            if(smokie!='')
                            Text('Smokie:', style: dashboardStyle),
                            if(smokie!='')
                            Text(smokie, style: dashboardNumberStyle),
                          ]),
                          Row(
                            children: [
                            if(kebab!='')
                              Text('Kebab:', style: dashboardStyle),
                            if(kebab!='')
                              Text(kebab, style: dashboardNumberStyle),
                            if(smocha!='')
                              Text('Smocha:', style: dashboardStyle),
                            if(smocha!='')
                              Text(smocha, style: dashboardNumberStyle),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (isAdmin == true)
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('Phone').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('Orders').doc(id).update({'Status':'Sold Out'});
                                    
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sold out action'))); 
                                    
                                    },
                                    child: Text(
                                      'Sold out',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                if (isAdmin == false)
                                  TextButton(
                                    onPressed: () {
                                      
                                    },
                                    child: Text(
                                      status,
                                    ),
                                  ),
                                if (isAdmin == true)
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                    onPressed: () {
                                   //TODO: take order func   
                                      FirebaseFirestore.instance.collection('Phone').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('Orders').doc(id).update({'Status':'Order Taken'}).then((value) {
                                        try {
                                          print('sucess');
                                        } catch (e) {
                                          print(e);
                                        }
                                      });
                                    setState(() {
                                      status='Order Taken';
                                    });
                                    },
                                    child: Text(
                                      status,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                              ]),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

