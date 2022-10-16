import 'dart:collection';
// import 'package:mpesa/mpesa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';


Widget customItemView(BuildContext context, String title, String image) {
  return Card(
    margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
    elevation: 2,
    child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 150,
          color: Colors.amber,
          child: Image(
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            image: AssetImage(image),
          ),
        ),
        Positioned(
          top: 5,
          left: 10,
          child: Container(
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            child: Row(
              children: [
                InkWell(
                  onTap: () => customDialogue(context, title,'Buy'),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(
                      right: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Buy",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => customDialogue(context, title,'Order'),
                  child: Container(
                    margin: EdgeInsets.only(right: 20, bottom: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Order',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

customDialogue(BuildContext context, String title,String action) {
  String number = '';
  FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user=_auth.currentUser;
  int amount;
  int burgerPrice=50;
  int kebabPrice=30;
  int smochaPrice=50;
  int smokiePrice=30;

  

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How many ' + title + 's' + ' would you like',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    //TODO:Try using a statefull widget in the futre allow user to add number dynamicaly
                    Container(
                        height: 50,
                        width: 100,
                        child: TextField(
                          onChanged: (value) => {number = value, print(number)},
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.blue,
                          cursorRadius: Radius.circular(4.0),
                          // cursorWidth: 15,
                          decoration: InputDecoration(
                            hintText: 'Number?',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 80),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () => {
                          
                          if (number == "")
                            {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please Enter an number',style:TextStyle(color: Colors.red),)))}
                          else{
                            if(action=='Buy'){
                          
                            if(_user==null){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please log in first!!',style:TextStyle(color: Colors.red),)))
                            }else{
                               addBoughtItem(title, number),
                             print('buy order succesful'),
                             if(title=='Burger'){
                              amount =burgerPrice*int.parse(number)
                             }else if(title=='Kebab'){
                              amount =kebabPrice*int.parse(number)
                             }else if(title=='Smokie'){
                                 amount =smokiePrice*int.parse(number)
                             }else {
                                 amount =smochaPrice*int.parse(number)
                             },
                             
                             startTransaction(amount.toDouble(), FirebaseAuth.instance.currentUser!.phoneNumber.toString())
                            }
                            }else{
                              if(_user==null){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please log in first!!',style:TextStyle(color: Colors.red),)))
                              }else{
                                addOrder(title,number),
                               print('order placed succesfull'),
                               if(title=='Burger'){
                              amount =burgerPrice*int.parse(number)
                             }else if(title=='Kebab'){
                              amount =kebabPrice*int.parse(number)
                             }else if(title=='Smokie'){
                                 amount =smokiePrice*int.parse(number)
                             }else {
                                 amount =smochaPrice*int.parse(number)
                             },
                               startTransaction(amount.toDouble(), FirebaseAuth.instance.currentUser!.phoneNumber.toString())
                              // runAmain()
                              }
                            },
                             Navigator.of(context).pop(),
                            }
                        },
                        child: Text(
                          action,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

addOrder(String orderItem,String number) {
Map<String,dynamic> neworder={orderItem:number};
User? _user=FirebaseAuth.instance.currentUser;
//TODO:wrap in try catch block
 Map<String,dynamic> checkItem(){
  Map<String,dynamic> neworder;
  if(orderItem=='Burger'){
   return neworder={'Burger':number,'Kebab':'','Smokie':'','Smocha':'','Status':'Pending'};
  }else if(orderItem=='Kebab'){
return neworder={'Burger':'','Kebab':number,'Smokie':'','Smocha':'','Status':'Pending'};
  }else if(orderItem=='Smokie'){
    return neworder={'Burger':'','Kebab':'','Smokie':number,'Smocha':'','Status':'Pending'};

  }else{
     return neworder={'Burger':'','Kebab':'','Smokie':'','Smocha':number,'Status':'Pending'};
  }

}
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Phone');
  collectionReference.doc(_user!.phoneNumber).collection('Orders').add(checkItem());
}
addBoughtItem(String itemBought,String number) {
 Map<String,dynamic>  checkItem(){
  Map<String,dynamic> newItemBought;
  if(itemBought=='Burger'){
   return newItemBought={'Burger':number,'Kebab':'','Smokie':'','Smocha':''};
  }else if(itemBought=='Kebab'){
return newItemBought={'Burger':'','Kebab':number,'Smokie':'','Smocha':''};
  }else if(itemBought=='Smokie'){
    return newItemBought={'Burger':'','Kebab':'','Smokie':number,'Smocha':''};

  }else{
     return newItemBought={'Burger':'','Kebab':'','Smokie':'','Smocha':number};
  }

}
User? _user=FirebaseAuth.instance.currentUser;
  // CollectionReference collectionReference=FirebaseFirestore.instance.collection('Bought');
  // collectionReference.doc(_user!.phoneNumber).set(newItemBought);
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Phone');
  collectionReference.doc(_user!.phoneNumber).collection('Purchases').add(checkItem());
}

makeOrder(number) {
//api call
}
buyItem(number){
//api call

}


Future<void> startTransaction(double amount ,String phoneNumber) async{
  dynamic transactionInitialisation;
 
  try {
phoneNumber=phoneNumber.substring(1);
print(phoneNumber);
  transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
                  businessShortCode: '174379',
                  transactionType:TransactionType.CustomerPayBillOnline,
                  amount: amount,
                  partyA:phoneNumber ,
                  partyB: '174379 ',
                  callBackURL:Uri(scheme: "https", host : "my-app.herokuapp.com", path: "/callback"),
                  accountReference: 'Billy Obunde',
                  phoneNumber: phoneNumber,
                  baseUri:Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
                  transactionDesc: 'Stay dangerous!',
                  passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'
                  
                  )
                  
                  ;
                  
  
  HashMap result =transactionInitialisation as HashMap<String ,dynamic>;
 print(transactionInitialisation.toString());
 print('done');


  } catch (e) {
  //you can implement your exception handling here.
  //Network unreachability is a sure exception.
  print(e.toString());

  }
}





// void runAmain() {
  // final mpesa = Mpesa(
//     clientKey: "1VdadwI8wg7zrJ7FNkKJ38hrgspSAOMh",
//     clientSecret: "DZx8rLVyKsS3n1ZG",
//     passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
//     environment: "sandbox",
//   );

//   mpesa
//       .lipaNaMpesa(
//         phoneNumber: "254746443944",
//         amount: 1,
//         businessShortCode: "174379",
//         callbackUrl: "https://my-app.herokuapp.com/callback",
//       )
//       .then((result) {})
//       .catchError((error) {});
// }