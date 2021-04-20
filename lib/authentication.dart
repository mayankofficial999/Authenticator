import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
class Authentication
{
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }
  void signup(String a,String b) async
  {
    try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: a,
    password:b
  );
    } on FirebaseAuthException catch (e)
   {
    if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    }
    else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
   }
  }
  catch (e) {
  print(e);
  }
}

  void signin(String a,String b) async
  {
    try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: a,
    password: b
    );
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    }
    }
  }

  void checkLogin() async
  {
     if(FirebaseAuth.instance.currentUser?.uid == null){
                 print('User is logged out');
                 }
                 else {
                 // logged
                 print('User is logged in');
                 }
  }
}