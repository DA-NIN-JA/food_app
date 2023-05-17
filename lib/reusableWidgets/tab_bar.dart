import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/screens/donation_history_page.dart';
import 'package:food_app/screens/join_us_page.dart';

class FloatingTabBar extends StatelessWidget {
  const FloatingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                IconColumn(Icons.home_rounded, "Home", "/Home"),
                IconColumn(FontAwesomeIcons.heart, "My Donations",
                    DonationHistoryScreen.routeName),
                // IconColumn(Icons.person, "Profile"),
                IconColumn(Icons.join_full_rounded, "Work with Us",
                    JoinUsPage.routeName),
              ],
            ),
          ),
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
          child: Column(
            children: [
              Icon(
                icon,
                color: kwhite,
                size: 30,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 10, color: kwhite),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
        ),
      ],
    );
  }
}

class shadowBox extends StatelessWidget {
  const shadowBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                kblack.withOpacity(0.5),
                kwhite.withOpacity(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          // color: kblack
        ),
        height: 140,
        // color: kwhite.withOpacity(0.2),
      ),
    );
  }
}
