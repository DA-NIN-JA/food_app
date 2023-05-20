import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/screens/AuthPage.dart';
import 'package:food_app/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/back_button.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/UserProfile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    // up.User? currentUser;
    // Provider.of<UserProvider>(context, listen: false)
    //     .getUserInfo()
    //     .then((value) => currentUser = value)
    //     .then((value) => print(currentUser!.name));
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    if (currentUser.email != "") {
      return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.connectionState==ConnectionState.waiting) {
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
                      width: double.infinity, //Works without this
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  // foregroundImage:
                                  //     NetworkImage("https://picsum.photos/200"),
                                  backgroundColor: Colors.grey[500],
                                  radius: 60,
                                  child: const Icon(
                                    Icons.person,
                                    color: kwhite,
                                    size: 100,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  currentUser.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  currentUser.email,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: kgrey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
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
                                  onPress: () => Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .logout(context)),
                              const SizedBox(
                                height: 300,
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
                            splashRadius: 28))
                  ],
                ),
              ),
            );
          }
          else{
            return AuthPage();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      );
    } else {
      return const Scaffold(
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onPress,
        leading: Icon(icon, color: kwhite),
        title: Text(
          title,
          style: const TextStyle(color: kwhite),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        // style: ListTileStyle.list,
        trailing: trailings
            ? const Icon(
                Icons.arrow_forward,
                color: kgrey,
              )
            : null,
      ),
    );
  }
}
