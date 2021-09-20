import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/SignUpPage.dart';
import 'package:todo_app/service/Auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await authClass.logout();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>
                    SignUpPage()), (route) => false);

              },
              icon: Icon(Icons.logout))
        ],
      ),

    );
  }
}
