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

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final focus = FocusNode();
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login(context) async
  {
    // show the progress indicator
    loggingIn = true;

    try {
      
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      log(result.user.uid);
      loggingIn = false;

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Successfully logged in!", style:TextStyle(color: Colors.white)), backgroundColor: Colors.green,));
      
    } catch (e) {
      var message = "";

      switch (e.code) {
        case "ERROR_USER_NOT_FOUND":
          message = "The email you entered is not registered for an account";
          break;
        case "ERROR_WRONG_PASSWORD":
          message = "The password you entered is wrong, please try again";
          break;
        case "ERROR_USER_DISABLED":
          message = "Sorry, you are blocked from entering the app. Please contact support";
          break;
        default:
          message = "An error occured, please retry in a few moments";
      }

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message, style:TextStyle(color: Colors.white)), backgroundColor: Colors.red,));
      loggingIn = false;
    }

  }

  bool loggingIn = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: (Themes.darkMode) ? Colors.grey[850] : Colors.white,
      body: Builder(builder: (context) => 
        Stack(children: <Widget>[

          Center(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(0, 50, 0, 35), child: 
              Stack(children: <Widget>[
                Padding(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[

                (!Themes.darkMode) ? SizedBox(child: Image.asset('assets/images/sample_school_logo.png'), width:150) : SizedBox(child: Image.asset('assets/images/sample_school_logo_white.png'), width:150),
                Divider(color: Colors.transparent,  height: 45),

                Form(key: _loginFormKey, child: Column(children: <Widget>[

                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'E-mail address',
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    style: TextStyle(fontSize: 18),
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return "Please enter your email";
                      } 
                      else if (!EmailValidator.validate(value))
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
                    controller: _passwordController,
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
                        login(context);
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
          ),),

          if (loggingIn)
            AnimatedOpacity(child: Container(
              color: Theme.of(context).backgroundColor,
              child: Center(child: Column(
                mainAxisSize: MainAxisSize.min, children: <Widget>[
                CircularProgressIndicator(),
                Divider(color:Colors.transparent, height:25),
                Text("Please wait...", style: TextStyle(fontSize:18))
              ],)),
            ), opacity: (loggingIn) ? 0.95 : 0, duration: Duration(milliseconds: 500))

        ]
        )
      )
    );
  }
}