import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo_app/pages/SignInPage.dart';
import 'package:todo_app/service/Auth_service.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {

  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIDFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Phone Login",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,

          ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                (builder) => SignInPage()), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
        ),

      ),


      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              textField(),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                child: Row(
                  children: [

                    Expanded(child:
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    ),

                    Text("Enter 6 Digits OTP", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,

                    ),),


                    Expanded(child:
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),

              otpField(),
              SizedBox(
                height: 40,
              ),

              RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 16,

                      ),
                    ),

                    TextSpan(
                      text: "  00:$start",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 16,

                      ),
                    ),

                    TextSpan(
                      text: "  Sec",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 16,

                      ),
                    ),
                  ]
              )),

              SizedBox(
                height: 150,
              ),

              InkWell(
                onTap: (){
                  authClass.signInwithPhoneNumber(verificationIDFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 60,
                  decoration: BoxDecoration(
                    color: Color(0xffff9601),
                    borderRadius: BorderRadius.circular(15),


                  ),
                  child: Center(
                    child: Text("Let's Go",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xfffbe2ae),
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                ),
              )

            ],

          ),
        ),
      ),


    );
  }


  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }


  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery
          .of(context)
          .size
          .width,
      fieldWidth: 40,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(
          fontSize: 17,
          color: Colors.white
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
       smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),

      ),

      child: TextFormField(

        controller: phoneController,
        style: TextStyle(
          color: Colors.white,

        ),

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: TextStyle(

            fontSize: 17,
            color: Colors.white54,

          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 19, horizontal: 8),

          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text("(+92)", style: TextStyle(
              fontSize: 17,
              color: Colors.white,

            ),
            ),
          ),

          suffixIcon: InkWell(
            onTap: wait ? null : () async {
              startTimer();
              setState(() {
                start = 30;
                wait = true;
                buttonName = "Resend";
              });
              await authClass.verifyPhoneNumber
                ("+92 ${phoneController.text}", context,setData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(buttonName, style: TextStyle(
                fontSize: 17,
                color: wait ? Colors.grey : Colors.white,
                fontWeight: FontWeight.bold,

              ),
              ),
            ),
          ),

        ),
      ),


    );
  }
void setData(verificationId){
setState(() {
  verificationIDFinal=verificationId;
});
startTimer();
}

}




















