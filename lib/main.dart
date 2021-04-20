import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
String id='',pass='';
void main() {
  runApp(MaterialApp(home:LoginPage(),theme: ThemeData(primaryColor: Colors.pink[200],)));
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
      appBar: AppBar(title: Text("Authenticator",style: TextStyle(color: Colors.white,),),),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://t3.ftcdn.net/jpg/02/42/77/22/360_F_242772256_PRwokoyoXkDCIISNjfj9N3If0TPFtje8.jpg"),
          fit: BoxFit.cover)
        ),
        child:
        Column(
          children:
        [
          Center(child:
          Container(child:
          Text("Firebase",
          style: GoogleFonts.concertOne(
            fontStyle: FontStyle.normal,
            fontSize: 30,
            decoration:TextDecoration.underline,
            color: Colors.grey[800])
          ),
          margin: const EdgeInsets.only(top:80),
          )
          ),

          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child:
          //   Center(child:
          //   Text("Email/Phone Number"),
          //   ),
          // ),

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

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            ElevatedButton(onPressed: (){obj.signin(myController1.text, myController2.text);obj.checkLogin();},child: Text("Sign In"),),
            ElevatedButton(onPressed: (){obj.signup(myController1.text, myController2.text);},child: Text("Sign Up"),),
          ]),

          Center(child:
          Text("OR",style: TextStyle(fontSize: 18))
          ),

          Container(child:
          Center(child:
          Text("Sign In using :",style: TextStyle(fontSize: 18))
          ),
          margin: EdgeInsets.only(top:20,bottom:20),
          ),

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

               FloatingActionButton(
              backgroundColor: Colors.white,
              child:
               Image.asset('assets/icons/google.png',height: 50,width: 50,),
               onPressed:() async { await FirebaseAuth.instance.signOut();obj.checkLogin();}
               ),

               FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              child:
               Icon(Icons.phone,size: 30,),
               onPressed: (){},
               ),
              
          ]),
        ]
        )
      )
      );
  }
}
