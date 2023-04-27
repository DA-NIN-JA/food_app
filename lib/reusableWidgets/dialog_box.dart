import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';

void ErrorDialog(BuildContext context, String errorMessage) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      closeIcon: SizedBox(),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: kwhite),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: kblack,
        ),
      ],
      content: Text(
        errorMessage,
        style: TextStyle(fontSize: 14),
      ),
    ).show();
  }