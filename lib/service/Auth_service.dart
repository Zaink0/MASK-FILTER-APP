
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/pages/CameraWithMaskFilterScreen.dart';
import 'package:todo_app/pages/HomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass
{
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();



  Future<void> googleSignIn(BuildContext context)async{
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if(googleSignInAccount != null){
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      try {
        UserCredential userCredential = await
        auth.signInWithCredential(credential);
        storeTokenAndData(userCredential);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (builder)=>CameraWithMaskFiltersScreen()),
                (route) => false);

      }catch(e){
        final snackbar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }


    }else{
      final snackbar = SnackBar(content: Text("Not Able to Sign in"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

    }
    }catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

    }
  }
Future<void> storeTokenAndData(UserCredential userCredential)async{
  await storage.write(key: "token", value: userCredential.credential!.token.toString());
  await storage.write(key: "userCredential", value: userCredential.toString());
}
Future<String?> getToken() async{
    return await storage.read(key: "token");
}

Future <void> logout() async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    } catch(e){

    }


}

Future <void> verifyPhoneNumber(
    String phoneNumber,BuildContext context,Function setData) async{

    PhoneVerificationCompleted verificationCompleted =
    (PhoneAuthCredential phoneAuthCredential)async{
      showSnackBar(context, "Verification Completed");


    };


    PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception)
    {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
    (String verificationID,[int? forceResendtoken]) {

      showSnackBar(context, "Verification Code Sent on the Phpne Number");
      setData(verificationID);
    } as PhoneCodeSent;

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
    (String verificationID){

      showSnackBar(context, "Time Out");
    };
    try{
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber ,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }catch(e){
      showSnackBar(context, e.toString());

    }
}

Future<void> signInwithPhoneNumber(String verificationId,
    String smsCode,BuildContext context)async{
    try{

      AuthCredential credential = PhoneAuthProvider.credential
        (verificationId: verificationId,
          smsCode: smsCode);

      UserCredential userCredential
      = await auth.signInWithCredential(credential);

      storeTokenAndData(userCredential);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder)=>CameraWithMaskFiltersScreen()),
              (route) => false);
      
      showSnackBar(context, "Logged In");



    }catch(e){
      showSnackBar(context, e.toString());

    }
}

void showSnackBar(BuildContext context,String text){
  final snackbar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
}