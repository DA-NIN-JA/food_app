import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String initName = "";
  String initPhone = "";
  String initAddress = "";
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Changes Successful!!",
        style: const AlertStyle(
          titleStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        closeIcon: const SizedBox(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.of(context).pop(),
            color: kblack,
            child: const Text(
              "OK",
              style: TextStyle(color: kwhite),
            ),
          ),
        ],
        // content: Text(
        //   "We are on our way to pick up your parcel.",
        //   style: TextStyle(fontSize: 16),
        //   textAlign: TextAlign.center,
        // ),
      ).show().then((value) async {
        Navigator.of(context).pop();
      });
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
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      colors: [kwhite, kcyan],
                      center: Alignment.center,
                      radius: 0.9999)),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      const Text(
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
                      const SizedBox(
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
                                borderSide: const BorderSide(color: kgrey)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: kblack,
                            ),
                            label: const Text("Name"),
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
                      const SizedBox(
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
                                borderSide: const BorderSide(color: kgrey)),
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: kblack,
                            ),
                            label: const Text("Email"),
                          ),
                          style: const TextStyle(color: kgrey),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
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
                                borderSide: const BorderSide(color: kgrey)),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: kblack,
                            ),
                            label: const Text("Phone"),
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
                      const SizedBox(
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
                                borderSide: const BorderSide(color: kgrey)),
                            prefixIcon: const Icon(
                              Icons.home_rounded,
                              color: kblack,
                            ),
                            label: const Text("Address"),
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
                      const SizedBox(
                        height: 40,
                      ),
                      if (_editable)
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: saveForm,
                                style: const ButtonStyle(
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
                                child: const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 36),
                                  textAlign: TextAlign.center,
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
                left: 5,
                top: 5,
                child: IconButton(
                    iconSize: 40,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const BackIcon(),
                    splashRadius: 28)),
            Positioned(
                right: 10,
                top: 8,
                child: IconButton(
                    iconSize: 48,
                    onPressed: () {
                      toggleEdit();
                      _nameController.text = initName;
                      _phoneController.text = initPhone;
                      _addressController.text = initAddress;
                    },
                    icon: EditIcon(_editable),
                    splashRadius: 28)),
          ],
        ),
      ),
    );
  }
}

class EditIcon extends StatelessWidget {
  final editable;
  EditIcon(this.editable);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kblack,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          const BoxShadow(
              color: Colors.black54, blurRadius: 4, offset: Offset(0, 1))
        ],
      ),
      child: Center(
        child: Icon(editable ? FontAwesomeIcons.arrowRotateLeft : Icons.edit,
            color: kwhite, size: editable ? 28 : 32),
      ),
    );
  }
}
