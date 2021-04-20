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
          image: NetworkImage("https://t3.ftcdn.net/jpg/02/42/77/22/360_F_242772256_PRwokoyoXkDCIISNjfj9N3If0TPFtje8.jpg"),
          fit: BoxFit.cover)
        ),
        child: Container(),
      ),
    );
  }
}