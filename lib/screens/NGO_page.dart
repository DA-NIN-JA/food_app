import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/provider.dart';
import '../reusableWidgets/back_button.dart';


class NGOPage extends StatelessWidget {
  static const routeName = '/NGOpage';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kwhite, kcyan.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              padding: EdgeInsets.fromLTRB(
                  20, 70, 20, 0), // Padding for the overall column
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50), // Paddint so that there is extra scroll
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.gem, color: kblack, size: 18),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "For Children",
                              style: TextStyle(color: kblack, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: kgrey, size: 20),
                            Text(
                              "Delhi,India",
                              style: TextStyle(color: kgrey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: kgrey),
                        ),
                        padding: EdgeInsets.all(14),
                        // margin: EdgeInsets.symmetric(vertical: 8),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Text(
                              """ActionAid India is part of a global federation and a full affiliate of ActionAid International that has presence in over 40 countries worldwide. \n\nSince 1972, the poor and the excluded have been at the centre of their programs in India. In 2006, they got registered as an Indian organisation called ActionAid Association. \n\nThey are primarily a human rights organization. They work for the rights of disadvantaged women and children ensuring that they have good means of livelihood. ActionAid has empowered its women to take up roles in the society which till now were dominated by males,such as truck drivers, cab drivers etc."""),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconLabelButton(
                                icon: FontAwesomeIcons.earthAmericas,
                                title: "Website"),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconLabelButton(
                                    icon: Icons.call,
                                    title: "Phone",
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  IconLabelButton(
                                      icon: Icons.mail_rounded, title: "Email"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        // clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            border: Border.all(color: kgrey),
                            borderRadius: BorderRadius.circular(25)),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            "assets/location.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: kwhite.withOpacity(0),
                child: Text(
                  "ActionAid India",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
    );
  }
}

class IconLabelButton extends StatelessWidget {
  final IconData icon;
  final String title;

  IconLabelButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          SizedBox(
            height: 8,
          ),
          Text(title),
        ],
      ),
    );
  }
}
