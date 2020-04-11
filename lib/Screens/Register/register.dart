import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

enum AccountType { teacher, student }

class _RegisterScreenState extends State<RegisterScreen> {

  AccountType _accType = AccountType.student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Theme.of(context).backgroundColor,
         elevation: 0,
         leading: ButtonBar(children: <Widget>[
           IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.maybePop(context); })
         ],),
         title: Text("Create an Account", style: TextStyle(fontWeight: FontWeight.bold)),
         centerTitle: true,
       ),
       body: Center(child:
        Padding(child: 
          ListView(shrinkWrap: true, children: <Widget>[
            
            Icon(Icons.person_outline, color: Colors.grey, size: 80),
            Divider(height: 35, color: Colors.transparent),

            Align(alignment: Alignment.center, child: Text("Please select your role", style:TextStyle(fontSize: 18))),
            Divider(height: 15, color: Colors.transparent),

            Row(children: <Widget>[

              Expanded(child: 
                Card(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: 
                  Row(children: <Widget>[
                    Radio(
                      value: AccountType.student,
                      groupValue: _accType,
                      onChanged: (AccountType value) {
                        setState(() { _accType = value; });
                      },
                    ),

                    Text("I'm a Student", style: TextStyle(fontSize: 16))
                  ],)
                )
              )),

              Expanded(child: 
                Card(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: 
                  Row(children: <Widget>[
                    Radio(
                      value: AccountType.teacher,
                      groupValue: _accType,
                      onChanged: (AccountType value) {
                        setState(() { _accType = value; });
                      },
                    ),

                    Text("I'm a Teacher", style: TextStyle(fontSize: 16))
                  ],)
                )
              )),

            ],),

            Divider(height: 20, color: Colors.transparent),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'First name',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Last name',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email address',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

            Divider(height:20, color:Colors.transparent),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                obscureText: true,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

            Padding(child: 
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                obscureText: true,
                style: TextStyle(fontSize: 18)
              ), 
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),

        ],), padding: EdgeInsets.fromLTRB(30, 0, 30, 0)
        )
      ,)
    );
  }
}