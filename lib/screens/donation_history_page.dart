import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import '../providers/provider.dart';
import '../reusableWidgets/back_button.dart';
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
                "YES",
                style: TextStyle(color: kgrey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _exit = true;
                });
                SystemNavigator.pop();
              },
              color: kwhite,
            ),
            DialogButton(
              child: Text(
                "NO",
                style: TextStyle(color: kwhite),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: kblack,
            ),
          ],
          content: Text(
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
            ErrorDialog(context,
                "An occured has occured from the server. Please try again later.");
            return Scaffold();
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kwhite, kcyan],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kblack,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 110), // It is the padding for stack.
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                    bottom: 120), // It is the padding in scroll.
                                physics: AlwaysScrollableScrollPhysics(
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
                        child: Text(
                          "Donation History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Divider(
                        thickness: 2,
                        color: kgrey,
                      ),
                      top: 78,
                      left: 20,
                      right: 20,
                    ),
                    Positioned(
                      child: Container(
                        height: 114,
                        color: kwhite.withOpacity(0.2),
                      ),
                      bottom: 0,
                      left: 0,
                      right: 0,
                    ),
                    Positioned(
                      child: Center(child: FloatingTabBar()),
                      bottom: 50,
                      left: 20,
                      right: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            print(snapshot.error);
            return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Text(
              "Food pick-up",
              style: TextStyle(
                  color: kwhite, fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(
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
                child: Container(
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
