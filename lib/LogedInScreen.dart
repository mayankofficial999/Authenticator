import 'package:flutter/material.dart';
class LogedInPage extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child:Text("User Screen",style: TextStyle(color: Colors.white,),),),),
      body:Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.redd.it/y1ostvqnr4711.jpg"),
          fit: BoxFit.cover)
        ),
        child: Container(),
      ),
    );
  }
}