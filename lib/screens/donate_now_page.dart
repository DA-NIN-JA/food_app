import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../providers/provider.dart';
import '../constants.dart';
import '../reusableWidgets/back_button.dart';
import '../screens/home_screen.dart';
import '../reusableWidgets/pickUp_function.dart';

class DonateNowScreen extends StatefulWidget {
  static const routeName = "/DonateNowScreen";

  @override
  State<DonateNowScreen> createState() => _DonateNowScreenState();
}

class _DonateNowScreenState extends State<DonateNowScreen> {
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressFocus = FocusNode();
  var _isInit = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController;
    _phoneController;
    _addressFocus;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).currentUser;
    if (_isInit) {
      setState(() {
        _addressController.text = userData.address;
        _phoneController.text = userData.phone;
        _isInit = false;
      });
    }

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kwhite, kcyan],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 90, 20, 0),
                child: Column(
                  children: [
                    Divider(
                      color: kgrey,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pick-up Details:",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      // focusNode: _phoneFocus,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: kgrey)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: kblack,
                        ),
                        label: Text("Phone"),
                      ),
                      onFieldSubmitted: (value) => _addressController.text
                              .trim()
                              .isEmpty
                          ? FocusScope.of(context).requestFocus(_addressFocus)
                          : null,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: kblack),
                      // readOnly: _editable ? false : true,
                      // onTap: _editable
                      //     ? null
                      //     : () {
                      //         FocusScope.of(context).requestFocus(FocusNode());
                      //       },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      focusNode: _addressFocus,
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: kgrey)),
                        prefixIcon: Icon(
                          Icons.home_rounded,
                          color: kblack,
                        ),
                        label: Text("Address"),
                      ),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.streetAddress,
                      maxLength: 100,
                      maxLines: 1,
                      style: TextStyle(color: kblack),
                      // readOnly: _editable ? false : true,
                      // onTap: _editable
                      //     ? null
                      //     : () {
                      //         FocusScope.of(context).requestFocus(FocusNode());
                      //       },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BottomSheetInfoRow(title: "Pick-up Charges", info: "₹50"),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                      color: kblack.withOpacity(0.6),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BottomSheetInfoRow(
                      title: "Total Charges",
                      info: "₹50",
                      bold: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(kblack),
                          elevation: MaterialStatePropertyAll(10),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () => PickUpButton(
                          context,
                          _phoneController.text.trim(),
                          _addressController.text.trim(),
                        ),
                        child: Text(
                          "Confirm Pick Up",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 35,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: kwhite.withOpacity(0),
                  child: Text(
                    "Donate Food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: BackIcon(),
                    splashRadius: 28),
                left: 5,
                top: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
