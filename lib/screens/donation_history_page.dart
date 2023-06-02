import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import '../providers/provider.dart';
import '../reusableWidgets/tab_bar.dart';
import '../reusableWidgets/dialog_box.dart';

class DonationHistoryScreen extends StatefulWidget {
  static const routeName = "/DonationHistoryScreen";

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
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
          if (snapshot.hasError) {
            print(snapshot.error);
            // ErrorDialog(context,
            //     "An occured has occured from the server. Please try again later.");
            return Scaffold(
              body: Center(
                child: Text("An error occured from snapshot.error"),
              ),
            );
          } else if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            // final listNGOs = snapshot.data;
            return Scaffold(
              // appBar: AppBar(backgroundColor: kwhite,elevation: 0,),
              backgroundColor: kwhite,
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kwhite, kcyan],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kblack,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 85), // It is the padding for stack.
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    bottom: 120,
                                    top: 15), // It is the padding in scroll.
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemBuilder: (context, index) {
                                  return singleDonation(snapshot.data![index]);
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            ),
                    ),
                    Positioned(
                      top: 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: kwhite.withOpacity(0),
                        child: const Text(
                          "Donation History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 78,
                      left: 10,
                      right: 10,
                      child: Divider(
                        thickness: 2,
                        color: kgrey,
                      ),
                    ),
                    const shadowBox(),
                    const FloatingTabBar(),
                  ],
                ),
              ),
            );
          } else {
            print(snapshot.error);
            return const Scaffold(
              body: Center(
                child: Text("An occured has occured. Please try again later."),
              ),
            );
          }
        },
        future: Provider.of<HistoryProvider>(context, listen: false)
            .getListDonations(),
      ),
    );
  }
}

class singleDonation extends StatelessWidget {
  final DonationData donationItem;

  singleDonation(this.donationItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context)
      //     .pushNamed(NGOPage.routeName, arguments: NGOItem),
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kblack,
        ),
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            const Text(
              "Food pick-up",
              style: TextStyle(
                  color: kwhite, fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                "Date: ${DateFormat.yMMMMEEEEd().format(donationItem.date)}",
                style: TextStyle(
                  color: kwhite.withOpacity(0.9),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    donationItem.address,
                    style: TextStyle(color: kwhite.withOpacity(0.6)),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
