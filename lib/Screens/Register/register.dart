import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

enum AccountType { teacher, student }

class _RegisterScreenState extends State<RegisterScreen> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController(); 
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  AccountType _accType = AccountType.student;
  final _registerFormKey = GlobalKey<FormState>();
  bool registering = false;

  void register() async
  {
    registering = true;

    try
    {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailAddressController.text, password: _passwordController.text);

      var uid = result.user.uid;
      await Firestore.instance.collection("users").document(uid).setData(
        { 
          'email' : _emailAddressController.text,
          'first_name': _firstNameController.text,
          'last_name' : _lastNameController.text, 
          'phone' : _phoneNumberController.text, 
          'teacher' : (_accType == AccountType.teacher),
          'uid' : uid,
          'organization' : Organization.currentOrganizationId,
          'classes' : [],
        }
      );

      // user has been signed up
      Fluttertoast.showToast(
        msg: "Successfully signed up!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
      );

      User.retrieveUserData();

      Navigator.pushReplacementNamed(context, "/dashboard");

    } catch (e) {
      var message = "";
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE")
      {
        message = "The email you entered is already associated with one of our accounts";
      } else {
        message = "An error occured. Please try again later.";
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
      );

      registering = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var confirmPasswordController = _confirmPasswordController;
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Theme.of(context).backgroundColor,
         elevation: 0,
         leading: ButtonBar(children: <Widget>[
           IconButton(icon: Icon(Icons.arrow_back, color: (Themes.darkMode) ?  Colors.white : Colors.grey[600], ), onPressed: () { Navigator.maybePop(context); })
         ],),
         title: Text("Create an Account", style: TextStyle(fontWeight: FontWeight.bold, color: (Themes.darkMode) ?  Colors.white : Theme.of(context).primaryColor)),
         centerTitle: true,
       ),
       body: Stack(children: <Widget>[
        Center(child:
          ListView(shrinkWrap: true, children: <Widget>[
            Padding(child: Column(children: <Widget>[
            
            Icon(Icons.person_outline, color: Colors.grey, size: 55),
            Divider(height: 15, color: Colors.transparent),

            Align(alignment: Alignment.center, child: Text("Please select your role", style:TextStyle(fontSize: 18))),
            Divider(height: 15, color: Colors.transparent),

            Row(children: <Widget>[

              Expanded(child: 
                Card(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: 
                  Row(children: <Widget>[
                    Radio(
                      activeColor: Theme.of(context).primaryColor,
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
                      activeColor: Theme.of(context).primaryColor,
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

            Divider(height: 10, color: Colors.transparent),
            
            Form(key: _registerFormKey, child: Column(children: <Widget>[

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'First name',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  controller: _firstNameController,
                  validator: (value)
                  {
                    if (value.isEmpty)
                    {
                      return "Please enter your first name here";
                    }
                    
                    return null;
                  },
                ), 
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Last name',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  controller: _lastNameController,
                  validator: (value)
                  {
                    if (value.isEmpty)
                    {
                      return "Please enter your last name here";
                    }
                    
                    return null;
                  },
                ), 
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 18),
                  controller: _emailAddressController,
                  validator: (value)
                  {
                    if (value.isEmpty)
                    {
                      return "Please enter your email address";
                    } else if (!EmailValidator.validate(value))
                    {
                      return "Please enter a valid email address";
                    }
                    
                    return null;
                  },
                ), 
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 18),
                  controller: _phoneNumberController,
                  validator: (value)
                  {
                    if (value.isEmpty)
                    {
                      return "Please enter your phone number";
                    } else if (!((value.length == 10 && value.startsWith("0")) || (value.length == 11 && value.startsWith("94")) || (value.length == 12 && value.startsWith("+94"))))
                    {
                      return "Please enter a valid phone number";
                    }
                    
                    return null;
                  },
                ), 
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),

              Divider(height:11, color:Colors.transparent),

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  controller: _passwordController,
                  validator: (value)
                  {
                    if (value.length == 0)
                      return "Please enter a password";
                    if (value.length < 5)
                      return "The password isn't strong enough";

                    return null;
                  },
                ), 
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),

              Padding(child: 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  controller: confirmPasswordController,
                  validator: (value)
                  {
                    if (value.length == 0)
                      return "Please confirm your password";

                    if (value != _passwordController.text)
                      return "Passwords don't match";

                    return null;
                  }
                ), 
              padding: EdgeInsets.fromLTRB(0, 5, 0, 35)),

              Row(children: <Widget>[
                Expanded(child: RaisedButton(color: Theme.of(context).primaryColor, textColor: Colors.white, child: Text("CREATE ACCOUNT"), onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      register();
                    }
                 },))
              ],),

              Divider(height:20, color:Colors.transparent),

            ]))

        ],), padding: EdgeInsets.fromLTRB(30, 0, 30, 0))])
        ,),

        if (registering)
          AnimatedOpacity(child: Container(
            color: Theme.of(context).backgroundColor,
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min, children: <Widget>[
              CircularProgressIndicator(),
              Divider(color: Colors.transparent, height:25),
              Text("Please wait...", style: TextStyle(fontSize:18))
            ],)),
          ), opacity: (registering) ? 0.95 : 0, duration: Duration(milliseconds: 500))

       ],)
    );
  }
}