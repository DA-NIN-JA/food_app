import 'package:flutter/material.dart';
import '../screens/user_profile.dart';
import '../constants.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(UserProfile.routeName),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          decoration: BoxDecoration(
            // color: kblack,
            borderRadius: BorderRadius.circular(25),
          ),
          height: 50,
          width: 50,
          child: Icon(Icons.person, color: kblack, size: 36),
        ),
      ),
    );
  }
}