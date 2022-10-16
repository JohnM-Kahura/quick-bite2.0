import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbite/Config/colors.dart';

class Purchases extends StatefulWidget {
  const Purchases({Key? key}) : super(key: key);

  @override
  _PurchasesState createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  List orders = [];
  bool isAdmin = true;

  Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
      .collection('Phone')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .collection('Purchases')
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
                 
                 

                  return Card(
                    child: Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10,left: 0,),
                      child: Column(
                        children: [
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
                          
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

