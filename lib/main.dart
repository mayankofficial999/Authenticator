import 'dart:async';

import 'package:authenticator/LogedInScreen.dart';
import 'package:authenticator/PhoneAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MaterialApp(home:LoginPage(),theme: ThemeData(primaryColor: Colors.lightGreen[50],)));
  await Firebase.initializeApp();
  Duration(milliseconds: 1000);
}

class OTPcheck extends StatefulWidget {
  @override
  _OTPcheckState createState() => _OTPcheckState();
}

class _OTPcheckState extends State<OTPcheck> {
  var hint;
  bool showInputField = false;
  String heading= 'Verification';
  String buttonText='Get OTP';
  int c=0;
  String pin='';
  final myController3 = TextEditingController();
  bool visible=false;
  void changeProgress()
  {
    setState(() {
      visible=!visible;
    });
  }
  // final myController4 = TextEditingController();
  void changeInputField()
  {
    setState(() {
      showInputField=!showInputField;
      if(heading=='Verification')
      heading='Enter OTP';
      if(buttonText=='Get OTP')
      buttonText='Sign In';
    });
  }
  
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
          image: AssetImage('assets/background/y1ostvqnr4711.jpg'),
          fit: BoxFit.cover)
        ),
        child: 
        Stack(children:[
        Column(
          children:
        [
          //Title
          Center(child:
          Container(child:
          ClipOval(
          child: Image.asset("assets/icons/otpscreen.jpg"),
          ),
          margin: const EdgeInsets.only(top:120,bottom:50,left: 150,right: 150),
          )
          ),
          Text('$heading',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)),
          Text(''),
          showInputField? otpbox():phoneNumber(),
          Text(''),
          ElevatedButton(onPressed: () async{
            Firebase.initializeApp();
            changeProgress();
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) 
              { 
                print('User is logged out !');
              }
              else
              {
                print('User is logged in !');
                changeProgress();
                Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
              }
              });
            if(showInputField==false)
            {
              await PhoneAuth(myController3.text,pin,context).verifyPhone(0);
            Timer(Duration(seconds: 5),()async{
              changeInputField();
              changeProgress();});
            }
            else
            await PhoneAuth(myController3.text,pin,context).verifyPhone(1);
            // if(code==1)
            // {
            //   changeProgress();
            //   Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
            // }
            // else if(code==2)
            // {
            //   changeInputField();
            //   changeProgress();
            // }
            // else if(code==3)
            // {
            //   changeProgress();
            //   Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
            // }
            // FirebaseAuth.instance.authStateChanges().listen((User? user) {
            //     if (user == null) {     
            //       if(heading=='Verification'&&myController3.text.length==13)
            //       {
            //       changeProgress();
            //       Timer(Duration(milliseconds: 1000),(){changeInputField();changeProgress();});}
            //       else if(heading=='Enter OTP'&&pin.length==6)
            //       {
            //         changeProgress();
            //       Timer(Duration(milliseconds: 5000),(){changeProgress();});
            //       }
            //     } else {
            //       pin='';
            //       Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
            //       print('User is signed in!');
            //     }
            //     });
            }, child: Text('      $buttonText      ')),
        ]
        ),
        Center(child:SizedBox(height:100,width: 100,child:
          visible? 
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
            strokeWidth: 10,
            semanticsLabel: 'Loading ...',
          ) 
          :
          Container(),
          ),
          ),
        ]
        ),
      ),
    );
  }
  Widget phoneNumber(){
    return Container(child:
          TextFormField(
              decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(),
              hintText: '+91XXXXXXXXXX',
              labelText: 'Phone Number',
              ),
              controller: myController3,
            ),
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          );
  }

  Widget otpbox(){
    return Container(child:
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 25,
            style: TextStyle(
              fontSize: 17
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onChanged: (pin1) {
              print("Completed: " + pin1);
              pin=pin1;
            },
            onCompleted: (pin1) async{pin=pin1;
            changeProgress();
            Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
            }
          ),
          margin: EdgeInsets.only(bottom:30,left:20,right:20),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
 
class _LoginPageState extends State<LoginPage> {
  //bool _isSigningIn = false;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  bool visible1=false;
  bool visible2=false;
  bool visible3=false;
  bool visible4=false;
  void changeProgress(int i)
  {
    setState(() {
      if(i==1)
      visible1=!visible1;
      else if(i==2)
      visible2=!visible2;
      else if(i==3)
      visible3=!visible3;
      else if(i==4)
      visible4=!visible4;
    });
  }
  @override
  Widget build(BuildContext context) {
  final obj =Authentication(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Center(child:Text("Authenticator",style: TextStyle(color: Colors.white,),),),),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/y1ostvqnr4711.jpg'),
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
              obscureText: true,
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
            Stack(children:[
                SizedBox(height:36,width: 80,child:
                visible3? 
                LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                  minHeight: 1,
                ) 
                :
                Container(),),
            ElevatedButton(onPressed: () {
              changeProgress(3);
              Authentication(context);
              Timer(Duration(milliseconds: 500),(){
              obj.signin(myController1.text,myController2.text);
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if(user!=null)
              Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
              }
              );
              changeProgress(3);
              });
              },
              child: Text("Sign In"),
              ),
              ]
              ),

            Stack(children:[
                SizedBox(height:36,width: 80,child:
                visible4? 
                LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                  minHeight: 1,
                ) 
                :
                Container(),),
            ElevatedButton(onPressed: () {
              changeProgress(4);
              Authentication(context);
              Timer(Duration(milliseconds: 500),(){
              obj.signup(myController1.text,myController2.text);
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if(user!=null)
              Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
              }
              );
              changeProgress(4);
              });
              },
              child: Text("Sign Up"),
              ),
              ]
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
              Stack(children:[
                SizedBox(height:56,width: 54,child:
                visible1? 
                CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  strokeWidth: 15,
                ) 
                :
                Container(), 
               ),
              // Google Sign In Icon
               FloatingActionButton(
                 heroTag: 'btn1',
              backgroundColor: Colors.white,
              child:
               Image.asset('assets/icons/google.png',height: 50,width: 50,),
               onPressed:() async {
                  Authentication(context);
                  obj.signInWithGoogle();
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    changeProgress(1);
                  } else {
                    changeProgress(1);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LogedInPage()),);
                    print('User is signed in!');
                  }
                  });
                 }
               ),
              ]
              ),

              Stack(children:[
                SizedBox(height:56,width: 54,child:
                visible2? 
                CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  strokeWidth: 15,
                ) 
                :
                Container(), 
               ),
              //OTP-Sign In Icon
               FloatingActionButton(
                 heroTag: 'btn2',
              backgroundColor: Colors.blueAccent,
              child:
               Icon(Icons.phone,size: 30,),
               onPressed: (){changeProgress(2);Timer(Duration(milliseconds: 500),(){Navigator.push(context,MaterialPageRoute(builder: (context) => OTPcheck()),);changeProgress(2);});},
               ),
              ]
              ),
          ]),
        ]
        )
      )
      );
  }
}