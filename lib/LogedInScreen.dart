import 'package:authenticator/authentication.dart';
import 'package:authenticator/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LogedInPage extends StatefulWidget{
  @override
  _LogedInPageState createState() => _LogedInPageState();
}

class _LogedInPageState extends State<LogedInPage> {

  String checkName()
  {
    if(FirebaseAuth.instance.currentUser?.displayName==null)
    return " Hello New User!";
    else
    return FirebaseAuth.instance.currentUser?.displayName as String;
  }

  String checkMail()
  {
    if(FirebaseAuth.instance.currentUser?.email==null)
    return "default@example.com";
    else
    return FirebaseAuth.instance.currentUser?.email as String;
  }

  @override
  Widget build(BuildContext context) {
    final obj=Authentication(context);
    return Scaffold(
      //appBar: AppBar(title: Center(child:Text("User Screen",style: TextStyle(color: Colors.white,),),),),
      body:Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/y1ostvqnr4711.jpg'),
          fit: BoxFit.cover,)
        ),
        child: Column(
          children:
        [
          //Title
          Center(child:
          Container(child:
          ClipOval(
          child: FirebaseAuth.instance.currentUser?.photoURL==null ? Image.asset('assets/icons/default.png') : 
          Image.network(FirebaseAuth.instance.currentUser?.photoURL as String,fit:BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress==null)
              return child;
            else
              return CircularProgressIndicator(strokeWidth: 5,);
          },
          ),
          ),
          margin: const EdgeInsets.only(top:200,bottom:40,left: 150,right: 150),
          )
          ),
          //Name
          Center(child:
          Row(mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
           Text("Name: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
           Text(checkName(),style: TextStyle(fontSize: 18),),
          ]
          ),
          ),
          //Email
          Center(child:
          Row(mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
           Text("Email: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
           Text(checkMail(),style: TextStyle(fontSize: 18)),
           Text('\n'),
          ]
          )
          ),
          //Log-Out Button
          Center(child:
          ElevatedButton(
          onPressed: () async {
            obj.logout();
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);
                print('User is signed out!');
              } else {
                print('');
              }
              });
          },
          child: Text('Sign Out')),
          ),
        ],
        ),
      ),
    );
  }
}
