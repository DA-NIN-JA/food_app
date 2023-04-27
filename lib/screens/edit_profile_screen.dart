import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/reusableWidgets/dialog_box.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../reusableWidgets/back_button.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/EditProfileScreen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    print(user.name);
    return Scaffold(
      // appBar: AppBar(backgroundColor: kwhite,elevation: 0,),
      backgroundColor: kwhite,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [kwhite, kcyan],
                      center: Alignment.center,
                      radius: 0.9999)),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: _nameFocus,
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: kgrey)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: kblack,
                          ),
                          label: Text("Name"),
                        ),
                        onFieldSubmitted: (value) => _phoneController.text
                                .trim()
                                .isEmpty
                            ? FocusScope.of(context).requestFocus(_phoneFocus)
                            : null,
                        keyboardType: TextInputType.name,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onDoubleTap: () => ErrorDialog(
                            context, "Email Address cannot be changed."),
                        child: TextFormField(
                          focusNode: _emailFocus,
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: kgrey)),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: kblack,
                            ),
                            label: Text("Email"),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          // onTapOutside: (event) => Focus.of(context).unfocus(),
                          // validator: (value) {
                          //   return value.toString().isEmpty ? "Required Field" : null;
                          // },
                          // onFieldSubmitted: (value) => _passwordController.text
                          //         .trim()
                          //         .isEmpty
                          //     ? FocusScope.of(context).requestFocus(_passFocus)
                          //     : null,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ),
                      TextFormField(
                        focusNode: _phoneFocus,
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
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.multiline,
                        maxLength: 100,
                        maxLines: 1,
                      ),
                    ],
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
                top: 5)
          ],
        ),
      ),
    );
  }
}
