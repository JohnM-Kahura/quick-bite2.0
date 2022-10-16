import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:quickbite/Screens/Auth/Phone_Auth.dart';
import 'package:quickbite/Screens/Home/config.dart';
import 'Screens/Home/Home.dart';

Future<void> main() async {
  MpesaFlutterPlugin.setConsumerKey(consumerKey);
  MpesaFlutterPlugin.setConsumerSecret(consumerSecret);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Bite',
      
      home: Initializer(),
    );
  }
}
class Initializer extends StatefulWidget {
  const Initializer({ Key? key }) : super(key: key);

  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  late FirebaseAuth _auth;
  late User? _user;
  bool isloading=true;
 
  @override
  void initState() {
   
    super.initState();
    _auth=FirebaseAuth.instance;
    _user=_auth.currentUser;
    print(_auth.currentUser);
    isloading=false;
    print(_user);
  }
  @override
  Widget build(BuildContext context) {
    return isloading?Scaffold(

      body: CircularProgressIndicator(),
    
    ):_user==null ? Authentication():Home();
  }
}

