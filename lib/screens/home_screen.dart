import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/donate_now_page.dart';
import '../constants.dart';
import '../providers/provider.dart' as up;
import '../reusableWidgets/dialog_box.dart';
import '../reusableWidgets/tab_bar.dart';
import '../screens/NGO_list_page.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/user_profile_icon.dart';
import '../reusableWidgets/pickUp_function.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _exit = false;

  @override
  Widget build(BuildContext context) {
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
      child: FutureBuilder(
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
                  child: Stack(
                    children: [
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kblack,
                              ),
                            )
                          : SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      "Hi ${userData!.name.split(" ")[0]},",
                                      style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600,
                                          color: kblack),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
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
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
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
                                            const MaterialStatePropertyAll(
                                                kblack),
                                        fixedSize:
                                            const MaterialStatePropertyAll(
                                          Size(250, 100),
                                        ),
                                        elevation:
                                            const MaterialStatePropertyAll(10),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Donate Now",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(NGOsList.routeName),
                                      style: ButtonStyle(
                                        elevation:
                                            const MaterialStatePropertyAll(10),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                kblack),
                                        fixedSize:
                                            const MaterialStatePropertyAll(
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
                                      child: const Text(
                                        "Connect with NGOs",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 125),
                                  const Text(
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
                      const FloatingTabBar(),
                      const Positioned(
                        right: 10,
                        top: 10,
                        child: ProfileIcon(),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            print(snapshot.error);
            // ErrorDialog(context,
            //     "An error occured from the server. Please try again later.");
            return const Scaffold(
              body: Center(
                child: Text("An Error occured by snapshot.error."),
              ),
            );
          }
        },
        future:
            Provider.of<up.UserProvider>(context, listen: false).getUserInfo(),
      ),
    );
  }
}

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.userData,
  });

  final up.User? userData;

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
            const SizedBox(
              height: 20,
            ),
            BottomSheetInfoRow(
              title: "Pick-up Address: ",
              info: userData!.address,
            ),
            const SizedBox(
              height: 20,
            ),
            BottomSheetInfoRow(title: "Phone: ", info: userData!.phone),
            const SizedBox(
              height: 60,
            ),
            BottomSheetInfoRow(title: "Pick-up Charges", info: "₹50"),
            const SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
              color: kblack.withOpacity(0.7),
            ),
            const SizedBox(
              height: 5,
            ),
            BottomSheetInfoRow(
              title: "Total Charges",
              info: "₹50",
              bold: true,
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    // borderRadius:
                    //     BorderRadius
                    //         .circular(
                    //             10),
                  ),
                  child: const Text(
                    "On Our Way!!",
                    style: TextStyle(
                        color: kwhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Dismissible(
                  key: UniqueKey(),
                  dragStartBehavior: DragStartBehavior.start,
                  background: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      // borderRadius:
                      //     BorderRadius
                      //         .circular(10),
                    ),
                  ),
                  onDismissed: (direction) async => {
                    PickUpButton(context, userData!.phone, userData!.address,
                        isSwipe: true),
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      // borderRadius:
                      //     BorderRadius
                      //         .circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
          style: const TextStyle(
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
