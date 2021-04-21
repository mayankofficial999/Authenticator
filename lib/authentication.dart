import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication
{
  Future<FirebaseApp> initializeFirebase() async 
  {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
    });
    return firebaseApp;
  }

  Future<User?> signInWithGoogle() async {
    initializeFirebase();
    FirebaseAuth auth = FirebaseAuth.instance;
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
        return userCredential.user;
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

  Future<User?> signup(String a,String b) async
  {
    initializeFirebase();
    try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: a,
    password:b
    );
    return userCredential.user;
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

  Future<User?> signin(String a,String b) async
  {
    initializeFirebase();
    try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: a,
    password: b
    );
    return userCredential.user;
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    }
    }
  }

  // void checkLogin() async
  // {
  //   if(FirebaseAuth.instance.currentUser?.uid == null){
  //     print('User is logged out');
  //   }
  //   else{
  //     // logged
  //     print('User is logged in');
  //   }
  // }

  void logoutEmail() async
  {
    await FirebaseAuth.instance.signOut();
  }
  void logoutGoogle() async
  {
    await GoogleSignIn().signOut();
  }
  void logout()
  {
    initializeFirebase();
    logoutEmail();
    logoutGoogle();
  }
}