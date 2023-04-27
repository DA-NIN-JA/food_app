import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constants.dart';
import '../reusableWidgets/back_button.dart';

class NGOPage extends StatelessWidget {
  static const routeName = '/NGOpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [kwhite,kcyan.withOpacity(0.8)],begin: Alignment.topLeft,end: Alignment.bottomRight)),
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "ActionAid India",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: kgrey),
                      ),
                      padding: EdgeInsets.all(14),
                      // margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          """ActionAid India is part of a global federation and a full affiliate of ActionAid International that has presence in over 40 countries worldwide. \n\nSince 1972, the poor and the excluded have been at the centre of their programs in India. In 2006, they got registered as an Indian organisation called ActionAid Association. \n\nThey are primarily a human rights organization. They work for the rights of disadvantaged women and children ensuring that they have good means of livelihood. ActionAid has empowered its women to take up roles in the society which till now were dominated by males,such as truck drivers, cab drivers etc."""),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.earthAmericas)),
                              Text("Website")
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.call_rounded)),
                                    Text("Phone")
                                  ],
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.mail_rounded)),
                                    Text("Email")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
            Positioned(
              child: IconButton(
                  onPressed: () {}, icon: BackIcon(), splashRadius: 28),
              left: 5,
              top: 5,
            )
          ],
        ),
      ),
    );
  }
}


