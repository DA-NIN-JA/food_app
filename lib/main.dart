import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:food_app/constants.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/screens/AuthPage.dart';
import 'package:food_app/screens/NGO_list_page.dart';
import 'package:food_app/screens/NGO_page.dart';
import 'package:food_app/screens/donate_now_page.dart';
import 'package:food_app/screens/edit_profile_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/user_profile.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NGOProvider(),
        ),
      ],
      child: MaterialApp(
        // darkTheme: ThemeData.dark(),
        title: "Food App",
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<auth.User?>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: kblack),
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text(
                    "Something went Wrong. Please try again later",
                    style: TextStyle(color: kgrey, fontSize: 24),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return AuthPage();
            }
          },
          stream: auth.FirebaseAuth.instance.authStateChanges(),
        ),
        theme: ThemeData(scaffoldBackgroundColor: kwhite),
        routes: {
          "/Home": (context) => HomeScreen(),
          NGOPage.routeName: (context) => NGOPage(),
          UserProfile.routeName: (context) => UserProfile(),
          NGOsList.routeName: (context) => NGOsList(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          AuthPage.routeName: (context) => AuthPage(),
          DonateNowScreen.routeName: (context) => DonateNowScreen(),
        },
      ),
    );
  }
}
