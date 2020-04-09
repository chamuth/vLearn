import 'dart:developer';
import 'dart:io';

import 'package:elearnapp/Core/Style.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final focus = FocusNode();
  final _loginFormKey = GlobalKey<FormState>();

  void login()
  {
    
  }

  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[850]);

    return Scaffold(
      backgroundColor: (Themes.current == Themes.dark) ? Colors.grey[850] : Colors.white,
      body: 
        Center(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(0, 50, 0, 35), child: Stack(children: <Widget>[
            Padding(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[

            (Themes.current == Themes.light) ? SizedBox(child: Image.asset('assets/images/sample_school_logo.png'), width:150) : SizedBox(child: Image.asset('assets/images/sample_school_logo_white.png'), width:150),
            Divider(color: Colors.transparent,  height: 45),

            Form(key: _loginFormKey, child: Column(children: <Widget>[

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'E-mail address',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 18),
                 validator: (value)
                {
                  if (value.isEmpty)
                  {
                    return "Please enter your email";
                  } else if (!EmailValidator.validate(value))
                  {
                    return "Please enter a valid email";
                  }
                  
                  return null;
                },
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(focus);
                },
              ),
              
              Divider(color: Colors.transparent,  height: 10),

              TextFormField(
                focusNode: focus,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
                style: TextStyle(fontSize: 18),
                validator: (value)
                {
                  if (value.isEmpty)
                  {
                    return "Please enter your password";
                  } 

                  return null;
                },
                onFieldSubmitted: (v)
                {
                  login();
                },
              ),

            ],),),

            Divider(color: Colors.transparent, height: 25),

            Align(alignment: Alignment.centerRight, ),

            Row(children: <Widget>[
              Expanded(flex:1, child: OutlineButton(child: 
                  Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                    Padding(child: Icon(Icons.email, size: 18), padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                    Text("CONTINUE WITH EMAIL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],)
              ,color: Colors.red, onPressed: () {
                  if (_loginFormKey.currentState.validate()) {
                    log("SHOWING SHIT");
                  }
              },))
            ],),


            Divider(color: Colors.transparent, height: 10),

            Row(children: <Widget>[
              Expanded(flex: 1, child: 
                TouchableOpacity(child: Text("Forgot your Password?", style: Styles.link), onTap: () { },)
              ),
              Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: 
                TouchableOpacity(child: Text("Create new Account", style: Styles.link), onTap: () { })
              ))
            ],),

            Divider(color: Colors.transparent, height: 25),

            Row(
                children: <Widget>[
                    Expanded(
                        child: Divider()
                    ),

                    Padding(padding: EdgeInsets.fromLTRB(11, 0, 11, 0), child: Opacity(child: Text("or sign in using Social Media", style: TextStyle(fontSize: 16)), opacity: 0.5)),  

                    Expanded(
                        child: Divider()
                    ),
                ]
            ),

          
            Divider(color: Colors.transparent, height: 25),

            Row(children: <Widget>[
              Expanded(flex:1, child: MaterialButton(child: 
                  Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                    Padding(child: FaIcon(FontAwesomeIcons.facebookF, size: 12), padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
                    Text("SIGN IN WITH FACEBOOK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],)
              ,color: Hexcolor("#3b5998"), textColor: Colors.white, onPressed: () {},))
            ],),

            Row(children: <Widget>[
              Expanded(flex:1, child: MaterialButton(child: 
                  Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                    Padding(child: FaIcon(FontAwesomeIcons.google, size: 12), padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
                    Text("SIGN IN WITH GOOGLE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],)
              ,color: Colors.white, textColor: Colors.blue, onPressed: () {},))
            ],),

            Row(children: <Widget>[
              Expanded(flex:1, child: MaterialButton(child: 
                  Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                    Padding(child: FaIcon(FontAwesomeIcons.twitter, size: 12), padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
                    Text("SIGN IN WITH TWITTER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],)
              ,color: Hexcolor("#00acee"), textColor: Colors.white, onPressed: () {},))
            ],),

          ],)
        , padding: EdgeInsets.fromLTRB(30, 0, 30, 0),)
        ]
        )
      )
    ,));
  }
}