import 'package:authenticator/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
class LogedInPage extends StatefulWidget{
  @override
  _LogedInPageState createState() => _LogedInPageState();
}

class _LogedInPageState extends State<LogedInPage> {
  final obj=Authentication();

  String checkUrl()
  {
    if(FirebaseAuth.instance.currentUser?.photoURL==null)
    return "https://aspire.rit.edu/sites/default/files/styles/image_large_thumbnail/public/default_images/profile-picture-default.png?itok=g_gy_X5Q";
    else
    return FirebaseAuth.instance.currentUser?.photoURL as String;
  }

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
    return " NA";
    else
    return FirebaseAuth.instance.currentUser?.email as String;
  }

    @override
  Widget build(BuildContext context) {
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
          child:
              Image.network(checkUrl(),
              fit: BoxFit.fill),
          ),
          margin: const EdgeInsets.only(top:200,bottom:40,left: 120,right: 120),
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
            Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);
          },
          child: Text('Sign Out')),
          ),
        ],
        ),
      ),
    );
  }
}
