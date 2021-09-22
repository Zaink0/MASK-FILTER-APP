import 'package:flutter/material.dart';
import 'package:todo_app/pages/SignInPage.dart';
import 'package:todo_app/pages/SignUpPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("assets/icon.png"),
            height: 160,

          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                CustomButton(
                  color: Colors.red,
                  text: "LOGIN",
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignInPage()), (route) => false);
                  },
                ),
                CustomButton(
                color: Colors.blue,
                text: "SIGN UP",
                onTap: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (builder) => SignUpPage()), (
                          route) => false);
                }
                ),




              ],

            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    Key? key, required this.color, required this.text,  required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        color: color,
        child: Center(
          child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 28

          ),),
        ),
      ),
    );
  }
}
