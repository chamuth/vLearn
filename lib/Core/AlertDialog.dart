import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,String title, String question, buttons) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(question),
    actions: buttons,
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Material(
      type: MaterialType.transparency,
      child: alert
    )
  );
}