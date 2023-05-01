import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/screens/donate_now_page.dart';
import '../constants.dart';
import '../providers/provider.dart' as up;
import '../reusableWidgets/dialog_box.dart';
import '../reusableWidgets/tab_bar.dart';
import '../screens/NGO_list_page.dart';
import '../screens/NGO_page.dart';
import '../screens/user_profile.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/user_profile_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          final userData = snapshot.data;
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
                                    "Hi ${userData!.name},",
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
                                    onPressed: () {
                                      if (userData.address != "" &&
                                          userData.phone != "") {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BottomSheetContainer(
                                                userData: userData);
                                          },
                                        );
                                      } else {
                                        Navigator.of(context).pushNamed(
                                            DonateNowScreen.routeName);
                                      }
                                    },
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
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(NGOsList.routeName),
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
      future:
          Provider.of<up.UserProvider>(context, listen: false).getUserInfo(),
    );
  }
}

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.userData,
  });

  final up.User? userData;

  void onSwipe(BuildContext context, String phone, String address) async {
    try {
      Provider.of<up.UserProvider>(context, listen: false)
          .addDonationTransaction(phone, address);
      Alert(
        context: context,
        type: AlertType.success,
        title: "Donation Successful!!",
        style: AlertStyle(
          titleStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        closeIcon: SizedBox(),
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: kwhite),
            ),
            onPressed: () => Navigator.of(context).pop(),
            color: kblack,
          ),
        ],
        content: Text(
          "We are on our way to pick up your parcel.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ).show().then((value) async {
        await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      ErrorDialog(
          context, "An error occured from the server. Please try again later.");
      return;
    } catch (error) {
      print(error);
      ErrorDialog(context, "An unknown error occured. Please try again later.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(DonateNowScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kwhite, kcyan.withOpacity(0.6)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BottomSheetInfoRow(title: "Pick-up from: ", info: userData!.name),
            SizedBox(
              height: 20,
            ),
            BottomSheetInfoRow(
              title: "Pick-up Address: ",
              info: userData!.address,
            ),
            SizedBox(
              height: 20,
            ),
            BottomSheetInfoRow(title: "Phone: ", info: userData!.phone),
            SizedBox(
              height: 60,
            ),
            BottomSheetInfoRow(title: "Pick-up Charges", info: "₹50"),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
              color: kblack.withOpacity(0.7),
            ),
            SizedBox(
              height: 5,
            ),
            BottomSheetInfoRow(
              title: "Total Charges",
              info: "₹50",
              bold: true,
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    // borderRadius:
                    //     BorderRadius
                    //         .circular(
                    //             10),
                  ),
                  child: Text(
                    "On Our Way!!",
                    style: TextStyle(
                        color: kwhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Dismissible(
                  key: UniqueKey(),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      // borderRadius:
                      //     BorderRadius
                      //         .circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Swipe to Donate",
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kwhite,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kwhite,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kwhite,
                        ),
                      ],
                    ),
                  ),
                  dragStartBehavior: DragStartBehavior.start,
                  background: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      // borderRadius:
                      //     BorderRadius
                      //         .circular(10),
                    ),
                  ),
                  onDismissed: (direction) async => {
                    onSwipe(context, userData!.phone, userData!.address),
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetInfoRow extends StatelessWidget {
  final String title;
  final String info;
  final bool bold;

  BottomSheetInfoRow(
      {required this.title, required this.info, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kgrey,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            info,
            style: TextStyle(
              color: kblack,
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : null,
            ),
            maxLines: 3,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
