import 'package:authenticator/LogedInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
void main() {
  runApp(MaterialApp(home:LoginPage(),theme: ThemeData(primaryColor: Colors.lightGreen[50],)));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
 
class _LoginPageState extends State<LoginPage> {
  //bool _isSigningIn = false;
  final obj =Authentication();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Center(child:Text("Authenticator",style: TextStyle(color: Colors.white,),),),),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.redd.it/y1ostvqnr4711.jpg"),
          fit: BoxFit.cover)
        ),
        child:
        Column(
          children:
        [
          //Title
          Center(child:
          Container(child:
          Text("Firebase",
          style: GoogleFonts.concertOne(
            fontStyle: FontStyle.normal,
            fontSize: 30,
            decoration:TextDecoration.underline,
            color: Colors.grey[800])
          ),
          margin: const EdgeInsets.only(top:200,bottom:30),
          )
          ),
          // Username-Input
          Container(child:
            TextFormField(
              decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Email',
              labelText: 'Username',
              ),
              controller: myController1,
              // onSaved: (String? value) {
              //   id= "$value";
              // },
            ),
            margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
            ),
          // Password-Input
          Container(child:
            TextFormField(
              decoration: const InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: 'Password',
              labelText: 'Password',
              ),
              controller: myController2,
              // onSaved: (String? value) {
              //   pass="$value";
              // }
            ),
            margin: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 40)
            ),
          //SignIn or SignUp Buttons
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            ElevatedButton(onPressed: () {
              obj.signin(myController1.text,myController2.text);
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if(user!=null)
              Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
              }
              );
              },
              child: Text("Sign In"),
              ),
            ElevatedButton(onPressed: () {
              obj.signup(myController1.text,myController2.text);
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if(user!=null)
              Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
              }
              );
              },
              child: Text("Sign Up"),
              ),
          ]),
          // OR Text
          Center(child:
          Text("OR",style: TextStyle(fontSize: 18))
          ),
          //Sign in using Text:
          Container(child:
          Center(child:
          Text("Sign In using :",style: TextStyle(fontSize: 18))
          ),
          margin: EdgeInsets.only(top:20,bottom:20),
          ),
          //Google and OTP Sign-In Buttons
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            // SignInButton(Buttons.Google,onPressed: () {},),
            // SignInButton(Buttons.Apple,onPressed: () {},),
            // SignInButtonBuilder(text: 'Sign in with Phone',icon: Icons.phone,onPressed: () {},backgroundColor: Colors.black),
              // FloatingActionButton(
              // backgroundColor: Colors.black,
              // child:
              //  ImageIcon(AssetImage("assets/icons/apple.png"),size: 30),
              //  onPressed: (){},
              //  ),
              // Google Sign In Icon
               FloatingActionButton(
                 heroTag: 'btn1',
              backgroundColor: Colors.white,
              child:
               Image.asset('assets/icons/google.png',height: 50,width: 50,),
               onPressed:() {obj.signInWithGoogle();if(FirebaseAuth.instance.currentUser!=null)Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);}
               ),
              //OTP-Sign In Icon
               FloatingActionButton(
                 heroTag: 'btn2',
              backgroundColor: Colors.blueAccent,
              child:
               Icon(Icons.phone,size: 30,),
               onPressed: (){obj.logoutEmail();},
               ),
              
          ]),
        ]
        )
      )
      );
  }
}