import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_app/pages/SignUpPage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: SignUpPage(),
      title: Text("CLIXEL MASK APP",style: TextStyle(
        fontSize: 55,
        color: Colors.deepPurpleAccent,
        fontFamily: "Signatra"
      ),),
      image: Image.asset("assets/icon.png"),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.deepPurpleAccent,
      loadingText: Text("Please Wait...",style: TextStyle(
        fontSize: 16.0,
       color: Colors.deepPurpleAccent,
       fontFamily: "Brand Bold"
      ),),

    );
  }
}

