import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/provider.dart' as up;
import '../reusableWidgets/dialog_box.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../reusableWidgets/tab_bar.dart';

class JoinUsPage extends StatefulWidget {
  static const routeName = "/JoinUsPage";

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _causeController = TextEditingController();
  final _causeFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  // String initName = "";
  // String initPhone = "";
  // String initAddress = "";
  // bool _isInit = true;
  var _exit = false;

  void causeValue(String value) {
    setState(() {
      _causeController.text = value;
    });
  }

  void saveForm() {
    if (_addressController.text.trim() == "" ||
        _phoneController.text.trim() == "" ||
        _descriptionController.text.trim() == "" ||
        _emailController.text.trim() == "" ||
        _nameController.text.trim() == "" ||
        _causeController.text.trim() == "") {
      ErrorDialog(context, "All details are required to register.");
    } else if (_phoneController.text.trim().length != 10) {
      ErrorDialog(context, "Enter a 10-digit mobile number.");
    } else {
      Provider.of<up.NGOProvider>(context, listen: false).addNGO(
        up.NGO(
          name: _nameController.text.trim(),
          address: _addressController.text.trim(),
          cause: _causeController.text.trim(),
          description: _descriptionController.text.trim(),
        ),
      );
      Alert(
        context: context,
        type: AlertType.success,
        title: "Joined Successfully!!",
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
        content: const Text(
          "Let's contribute to the society together.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ).show().then((value) async {
        Navigator.of(context).pushReplacementNamed("/Home");
      });
    }
  }

  @override
  void dispose() {
    _nameController;
    _emailController;
    _phoneController;
    _addressController;
    _descriptionController;
    _nameFocus;
    _emailFocus;
    _phoneFocus;
    _addressFocus;
    _descriptionFocus;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<up.UserProvider>(context).currentUser;
    // if (_isInit) {
    //   initName = _nameController.text = user.name;
    //   _emailController.text = user.email;
    //   initPhone = _phoneController.text = user.phone;
    //   initAddress = _addressController.text = user.address;
    //   setState(() {
    //     _isInit = false;
    //   });
    // }
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Caution!",
          style: const AlertStyle(
            titleStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          closeIcon: const SizedBox(),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _exit = true;
                });
                SystemNavigator.pop();
              },
              color: kwhite,
              child: const Text(
                "YES",
                style: TextStyle(color: kgrey),
              ),
            ),
            DialogButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: kblack,
              child: const Text(
                "NO",
                style: TextStyle(color: kwhite),
              ),
            ),
          ],
          content: const Text(
            "Are you sure you want to exit the app?",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ).show();

        return _exit;
      },
      child: Stack(
        children: [
          Scaffold(
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
                    padding: EdgeInsets.only(
                        top: 80, bottom: isKeyboardVisible ? 0 : 120),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
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
                                label: const Text("Name of NGO"),
                              ),
                              style: const TextStyle(color: kblack),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(_descriptionFocus),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _descriptionFocus,
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: kgrey)),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: kblack,
                                ),
                                label: const Text("Description"),
                              ),
                              style: const TextStyle(color: kblack),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocus),
                              keyboardType: TextInputType.name,
                              maxLength: 2500,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
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
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(_phoneFocus),
                              style: const TextStyle(color: kblack),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
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
                                  FocusScope.of(context)
                                      .requestFocus(_addressFocus),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: kblack),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
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
                              style: const TextStyle(color: kblack),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomDropdown(
                                _causeController, _causeFocus, causeValue),
                            const SizedBox(
                              height: 40,
                            ),
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
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: kwhite.withOpacity(0),
                      child: const Text(
                        "Join Us",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 70,
                    left: 20,
                    right: 20,
                    child: Divider(
                      thickness: 2,
                      color: kgrey,
                    ),
                  ),
                  // Positioned(
                  //   child: Container(
                  //     height: 115,
                  //     color: kwhite.withOpacity(0.2),
                  //   ),
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  // ),
                ],
              ),
            ),
          ),
          const FloatingTabBar(),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final Function setCause;

  CustomDropdown(this._controller, this._focusNode, this.setCause);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  final List<String> _items = [
    'Children',
    'Education & Literacy',
    'Specially Abled People',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        focusNode: widget._focusNode,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kblack, width: 1),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kblack),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kblack),
          ),
        ),
        hint: const Text(
          "Select Cause",
          style: TextStyle(fontSize: 17),
        ),
        iconEnabledColor: kblack,
        // focusColor: kblack,
        // decoration: InputDecoration(focusColor: kbla),
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.grey[300],
        style: const TextStyle(color: kblack),
        value: _selectedValue,
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
          widget.setCause(_selectedValue);
        },
        items: _items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
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
