import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'as firebase_auth;
import 'package:todo_app/pages/BottomPanel.dart';
import 'package:todo_app/pages/CameraWithMaskFilterScreen.dart';

import 'package:todo_app/pages/HomePage.dart';
import 'package:todo_app/pages/SignInPage.dart';
import 'package:todo_app/pages/SignUpPage.dart';
import 'package:todo_app/pages/splashScreen.dart';
import 'package:todo_app/service/Auth_service.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin()async{
    String? token = await authClass.getToken();
    if(token != null){
      setState(() {
        currentPage = currentPage;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomPanel(),

    );
  }
}
