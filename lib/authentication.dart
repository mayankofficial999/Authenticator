import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication
{
  Future<FirebaseApp> initializeFirebase() async 
  {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  void signInWithGoogle() async {
    initializeFirebase();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        print("Google Sign-In Successful");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          print("account-exists-with-different-credential");
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
          print("invalid-credential");
        }
      } catch (e) {
        // handle the error here
        print(e);
      }
    }
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

  void logout() async
  {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

}