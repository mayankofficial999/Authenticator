import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PhoneAuth
{
  final BuildContext context;
  Future<void> _showMyDialog(String x) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: 
              Text('$x'),
          ),
        );
      },
    );
  }
  FirebaseAuth auth= FirebaseAuth.instance;
  final String phoneNo;
  final String? otp;
  PhoneAuth(this.phoneNo,this.otp,this.context);
  Future<void> verifyPhone() async
  {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNo,
    verificationCompleted: (PhoneAuthCredential credential) async {
     await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      _showMyDialog(e.code);
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  },
    codeSent: (String verificationId, int? resendToken) async {
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = '$otp';

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  },
    codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}