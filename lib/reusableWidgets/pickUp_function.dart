import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../reusableWidgets/dialog_box.dart';
import '../constants.dart';

void PickUpButton(BuildContext context, String phone, String address, {bool isSwipe = false}) {
  if (phone == "" || address == "") {
    ErrorDialog(context, "Enter the details to proceed with the pickup.");
  } else if (phone.length != 10) {
    ErrorDialog(context, "Enter a 10-digit phone number.");
  } else {
    try {
      Provider.of<UserProvider>(context, listen: false)
          .addDonationTransaction(phone, address);
      Alert(
        context: context,
        type: AlertType.success,
        title: "Donation Successful!!",
        style: AlertStyle(
          titleStyle: TextStyle(
            fontSize: 22,
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
          "We are on our way to pick up your parcel.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ).show().then((value) async {
        if(isSwipe) await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      ErrorDialog(
          context, "An error occured from the server. Please try again later.");
      return;
    } catch (error) {
      print(error);
      ErrorDialog(context, "An unknown error occured. Please try again later.");
      return;
    }
  }
}
