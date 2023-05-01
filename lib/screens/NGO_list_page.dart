import 'package:flutter/material.dart';
import 'package:food_app/screens/NGO_page.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/dialog_box.dart';
import '../constants.dart';
import '../providers/provider.dart';
import '../reusableWidgets/back_button.dart';

class NGOsList extends StatelessWidget {
  static const routeName = '/NGOsList';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                                top: 80), // It is the padding for stack.
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  bottom: 10), // It is the padding in scroll.
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) {
                                return NGOListItem(snapshot.data![index]);
                              },
                              itemCount: snapshot.data!.length,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 40,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: kwhite.withOpacity(0),
                      child: Text(
                        "Connect with NGOs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
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
        } else {
          print(snapshot.error);
          ErrorDialog(
              context, "An occured has occured. Please try again later.");
          return Scaffold();
        }
      },
      future: Provider.of<NGOProvider>(context, listen: false).getListNGOs(),
    );
  }
}

class NGOListItem extends StatelessWidget {
  final NGO NGOItem;

  NGOListItem(this.NGOItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(NGOPage.routeName, arguments: NGOItem),
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kblack,
        ),
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Text(
              NGOItem.name,
              style: TextStyle(color: kwhite, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Cause: ${NGOItem.cause}",
                    style: TextStyle(
                      color: kwhite.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                NGOItem.address,
                style: TextStyle(color: kwhite.withOpacity(0.6)),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
