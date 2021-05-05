import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:MyApp(),theme: ThemeData(primaryColor: Colors.lightBlue[50],)));
}
enum UserSelect { Customer, Owner }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserSelect _site= UserSelect.Customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child:Text("App Name",style: TextStyle(color: Colors.white,),),),),
      body:  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Welcome',style: TextStyle(fontSize: 20),),
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(  
            title: const Text('Customer'),  
            leading: Radio(  
              value: UserSelect.Customer,  
              groupValue: _site,  
              onChanged: (UserSelect value) {  
                setState(() {  
                  _site = value;  
                });  
              },  
            ),  
          ),
          ListTile(  
            title: const Text('Shop Owner'),  
            leading: Radio(  
              value: UserSelect.Owner,  
              groupValue: _site,  
              onChanged: (UserSelect value) {  
                setState(() {  
                  _site = value;  
                });  
              },  
            ),  
          ),  
        ],
        ),
        
      ]
      )
    );
  }
}
