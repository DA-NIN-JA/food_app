import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/reusableWidgets/dialog_box.dart';
import 'package:food_app/reusableWidgets/tab_bar.dart';
import 'package:food_app/screens/user_profile.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/user_profile_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            // appBar: AppBar(),
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kwhite, kcyan.withOpacity(0.6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kblack,
                        ),
                      )
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Hi Dhairya,",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600,
                                        color: kblack),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "You have taken the first step towards donating already.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: kgrey),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Make sure the food is fresh.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: kgrey),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(kblack),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size(250, 100),
                                      ),
                                      elevation: MaterialStatePropertyAll(10),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Donate Now",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Connect with NGOs",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(10),
                                      backgroundColor:
                                          MaterialStatePropertyAll(kblack),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size(250, 100),
                                      ),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      splashFactory: InkSplash.splashFactory,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 115),
                                Text(
                                  "“They got money for wars but can’t feed the poor.” — Tupac Shakur",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kgrey,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Center(child: FloatingTabBar()),
                            bottom: 50,
                            left: 20,
                            right: 20,
                          ),
                          Positioned(
                            child: ProfileIcon(),
                            right: 10,
                            top: 10,
                          )
                        ],
                      ),
              ),
            ),
          );
        } else {
          print(snapshot.error);
          ErrorDialog(context,
              "An error occured from the server. Please try again later.");
          return Scaffold();
        }
        ;
      },
      future: Provider.of<UserProvider>(context, listen: false)
          .getUserInfo(context),
    );
  }
}
