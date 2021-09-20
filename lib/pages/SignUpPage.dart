import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart'as firebase_auth;
import 'package:todo_app/pages/HomePage.dart';
import 'package:todo_app/pages/PhoneAuthPage.dart';
import 'package:todo_app/service/Auth_service.dart';

import 'SignInPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _iphoneController = TextEditingController();
  bool circular = false;

  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up",style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(
                height: 20,
              ),

              buttonItem("assets/google.svg","Continue with Google",25,()async{

                await authClass.googleSignIn(context);


              },),
              SizedBox(
                height: 1,
              ),
              buttonItem("assets/phone.svg","Continue with Phone",25,(){

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (builder)=>PhoneAuthPage()), (route) => false);
              }),

              SizedBox(
                 height: 15,
              ),
              Text("Or",style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ),),
              SizedBox(
                height: 15,
              ),


              textItem("First Name...",_fnameController,false,TextInputType.text),
              SizedBox(
                height: 15,
              ),
              textItem("Phone Number...",_iphoneController,false,TextInputType.phone),
              SizedBox(
                height: 15,
              ),
              textItem("Email...",_emailController,false,TextInputType.emailAddress),
              SizedBox(
                height: 15,
              ),
              textItem("Password...",_passwordController,true,TextInputType.text),
              SizedBox(
                height: 35,
              ),
              colorButton(),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you already have an Account ?",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                          (builer)=>SignInPage()) , (route) => false);
                    },
                    child: Text("Login",style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              )
              

            ],
          ),
        ),
      ),

    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: () async{
        setState(() {
          circular = true;
        });
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>SignInPage()),
                  (route) => false);


        }catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });


        }


      },
      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)]
          )
        ),
        child: Center(
          child: circular?CircularProgressIndicator():Text("SignUp",style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),),
        ),
      ),
    );
  }
  Widget buttonItem(String imagepath,
      String buttonName,
      double size,
      Function onTap,
      ){

    return  InkWell(
      onTap:(){
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width-60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,
                color: Colors.grey,

              ),

          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(imagepath,
                height:size,
                width: size,),
              SizedBox(
                width: 20,
              ),

              Text(buttonName,style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),),


            ],
          ),
        ),
      ),
    );


  }

  Widget textItem(String labeltext,TextEditingController controller,bool obsecureText,TextInputType textInputType ){
    return Container(
      width: MediaQuery.of(context).size.width-70,
      height: 55,
      child: TextFormField(
        keyboardType: textInputType,
        controller:controller ,
        obscureText: obsecureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,

        ),
        decoration: InputDecoration(

          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.amber,

        ),
      ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,

            ),
          ),
        ),
      ),


    );
  }

}


