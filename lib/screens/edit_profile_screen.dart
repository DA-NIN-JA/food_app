import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/provider.dart' as up;
import '../reusableWidgets/dialog_box.dart';
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
  String initName="";
  String initPhone="";
  String initAddress="";
  bool _isInit = true;
  bool _editable = false;

  void toggleEdit() {
    setState(() {
      _editable = !_editable;
    });
  }

  void saveForm() {
    if (_phoneController.text.trim().length == 10) {
      toggleEdit();
      Provider.of<up.UserProvider>(context, listen: false).updateUser(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _addressController.text.trim(),
        context,
      );
    } else {
      ErrorDialog(context, "Enter a 10-digit mobile number.");
    }
  }

  @override
  void dispose() {
    _nameController;
    _emailController;
    _phoneController;
    _addressController;
    _nameFocus;
    _emailFocus;
    _phoneFocus;
    _addressFocus;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<up.UserProvider>(context).currentUser;
    if (_isInit) {
      initName = _nameController.text = user.name;
      _emailController.text = user.email;
      initPhone = _phoneController.text = user.phone;
      initAddress = _addressController.text = user.address;
      setState(() {
        _isInit = false;
      });
    }
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: 36,
                            shadows: [
                              Shadow(
                                  blurRadius: 4,
                                  offset: Offset(-1, 1.5),
                                  color: Colors.black45),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        behavior: _editable ? null : HitTestBehavior.opaque,
                        onDoubleTap: _editable
                            ? null
                            : () => ErrorDialog(
                                context, "Click on Edit to change details."),
                        child: TextFormField(
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
                          style: TextStyle(color: _editable ? kblack : kgrey),
                          onFieldSubmitted: (value) => _phoneController.text
                                  .trim()
                                  .isEmpty
                              ? FocusScope.of(context).requestFocus(_phoneFocus)
                              : null,
                          keyboardType: TextInputType.name,
                          readOnly: _editable ? false : true,
                          onTap: _editable
                              ? null
                              : () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          style: TextStyle(color: kgrey),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        behavior: _editable ? null : HitTestBehavior.opaque,
                        onDoubleTap: _editable
                            ? null
                            : () => ErrorDialog(
                                context, "Click on Edit to change details."),
                        child: TextFormField(
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
                          onFieldSubmitted: (value) =>
                              _addressController.text.trim().isEmpty
                                  ? FocusScope.of(context)
                                      .requestFocus(_addressFocus)
                                  : null,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: _editable ? kblack : kgrey),
                          readOnly: _editable ? false : true,
                          onTap: _editable
                              ? null
                              : () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        behavior: _editable ? null : HitTestBehavior.opaque,
                        onDoubleTap: _editable
                            ? null
                            : () => ErrorDialog(
                                context, "Click on Edit to change details."),
                        child: TextFormField(
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
                          keyboardType: TextInputType.streetAddress,
                          maxLength: 100,
                          maxLines: 1,
                          style: TextStyle(color: _editable ? kblack : kgrey),
                          readOnly: _editable ? false : true,
                          onTap: _editable
                              ? null
                              : () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (_editable)
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: saveForm,
                                child: Text(
                                  "Save",
                                  style: TextStyle(fontSize: 36),
                                  textAlign: TextAlign.center,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kblack),
                                  elevation: MaterialStatePropertyAll(5),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(100, double.infinity),
                                  ),
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 6),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                child: IconButton(
                    iconSize: 40,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: BackIcon(),
                    splashRadius: 28),
                left: 5,
                top: 5),
            Positioned(
                child: IconButton(
                    iconSize: 48,
                    onPressed: () {
                      toggleEdit();
                      _nameController.text = initName;
                      _phoneController.text = initPhone;
                      _addressController.text = initAddress;
                    },
                    icon: EditIcon(),
                    splashRadius: 28),
                right: 10,
                top: 8),
          ],
        ),
      ),
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kblack,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 1))
        ],
      ),
      child: Center(
        child: Icon(Icons.edit, color: kwhite, size: 32),
      ),
    );
  }
}
