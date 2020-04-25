import 'dart:developer';

import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    // load current organization details
    Organization.loadCurrentOrganizationDetails().then((val) 
    {
      if (val)
      {
        Future.delayed(const Duration(seconds: 1), () {
          FirebaseAuth.instance
              .currentUser()
              .then((currentUser) 
              {
                if (currentUser == null)
                  Navigator.pushReplacementNamed(context, "/login");
                else 
                {
                  User.retrieveUserData().then((res) {
                    Navigator.pushReplacementNamed(context, "/dashboard");
                  });
                }
              });    
        });
      } else {
        // exit the program
        SystemNavigator.pop();
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child:  SizedBox(width: 150, child: Image.asset("assets/images/sample_school_logo_white.png"))
        ),
      ),
    );
  }
}