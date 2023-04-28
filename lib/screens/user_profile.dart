import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/screens/AuthPage.dart';
import 'package:food_app/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart' as up;
import '../reusableWidgets/back_button.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/UserProfile';

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/Home");
  }

  @override
  Widget build(BuildContext context) {
    // up.User? currentUser;
    // Provider.of<UserProvider>(context, listen: false)
    //     .getUserInfo()
    //     .then((value) => currentUser = value)
    //     .then((value) => print(currentUser!.name));
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    if (currentUser.email != "") {
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
                width: double.infinity, //Works without this
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            foregroundImage:
                                NetworkImage("https://picsum.photos/200"),
                            radius: 60,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            currentUser.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            currentUser.email,
                            style: TextStyle(
                                fontSize: 12,
                                color: kgrey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListItem(
                            icon: Icons.person,
                            title: "Personal Details",
                            onPress: () => Navigator.of(context)
                                .pushNamed(EditProfileScreen.routeName)),
                        ListItem(
                            icon: Icons.help_outline_rounded,
                            title: "Help and Support",
                            onPress: () {}),
                        ListItem(
                            icon: Icons.settings,
                            title: "Settings",
                            onPress: () {}),
                        ListItem(
                            icon: Icons.person_add_alt_1,
                            title: "Invite a Friend",
                            onPress: () {}),
                        ListItem(
                            icon: Icons.logout_rounded,
                            title: "Logout",
                            trailings: false,
                            onPress: () => logout(context)),
                        SizedBox(
                          height: 300,
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
                  top: 5)
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text("An error occured. Please try again later."),
        ),
      );
    }
  }
}

class ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool trailings;
  final VoidCallback onPress;

  ListItem({
    required this.icon,
    required this.title,
    required this.onPress,
    this.trailings = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: kblack,
      ),
      child: ListTile(
        onTap: onPress,
        leading: Icon(icon, color: kwhite),
        title: Text(
          title,
          style: TextStyle(color: kwhite),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        // style: ListTileStyle.list,
        trailing: trailings
            ? Icon(
                Icons.arrow_forward,
                color: kgrey,
              )
            : null,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
