import 'package:firebase_auth/firebase_auth.dart';
class PhoneAuth
{
  FirebaseAuth auth= FirebaseAuth.instance;
  final String phoneNo;
  final String? otp;
  PhoneAuth(this.phoneNo,this.otp);
  Future<String?> verifyPhone() async
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
     return null;
    },
    verificationFailed: (FirebaseAuthException e) {
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