import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/screens/user_profile.dart';

class FloatingTabBar extends StatelessWidget {
  const FloatingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 20,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kblack,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconColumn(Icons.home_rounded, "Home","/Home"),
            IconColumn(FontAwesomeIcons.heart, "My Donations","/Home"),
            // IconColumn(Icons.person, "Profile"),
            IconColumn(Icons.join_full_rounded, "Work with Us","/Home"),
          ],
        ),
      ),
    );
  }
}

class IconColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;
  IconColumn(this.icon, this.title, this.routeName);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Icon(icon, color: kwhite, size: 30,),
          onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 10, color: kwhite),
        ),
      ],
    );
  }
}
