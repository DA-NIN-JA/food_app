import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:food_app/main.dart';
import 'package:food_app/reusableWidgets/dialog_box.dart';
import 'package:provider/provider.dart';
import '../screens/AuthPage.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final String address;

  User(
      {required this.name,
      required this.email,
      this.address = "",
      this.imageUrl = "",
      this.phone = ""});
}

class UserProvider with ChangeNotifier {
  User _currentUser = User(name: "", email: "");

  User get currentUser {
    return User(
      name: _currentUser.name,
      email: _currentUser.email,
      address: _currentUser.address,
      imageUrl: _currentUser.imageUrl,
      phone: _currentUser.phone,
    );
  }

  void addUser(User user, String userId) {
    try {
      FirebaseFirestore.instance.collection("users").doc(userId).set({
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "imageUrl": user.imageUrl,
        "address": user.address,
      });
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<User> getUserInfo(BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      _currentUser = User(
        name: userData["name"],
        email: userData["email"],
        address: userData["address"],
        imageUrl: userData["imageUrl"],
        phone: userData["phone"],
      );
      notifyListeners();
      return _currentUser;
    } on PlatformException catch (e) {
      ErrorDialog(context,
          "An error has occured from the server. Please try again later.");
      return _currentUser;
    } catch (error) {
      print(error);
      ErrorDialog(context, "An error has occured. Please try again later.");
      return _currentUser;
    }
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  void updateUser(
      String name, String phone, String address, BuildContext context) {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance.collection("users").doc(userId).update({
        "name": name,
        "phone": phone,
        "address": address,
      });
    } on PlatformException catch (e) {
      ErrorDialog(context,
          "An error has occured from the server. Please try again later.");
    } catch (error) {
      print(error);
      ErrorDialog(context, "An error has occured. Please try again later.");
    }

    notifyListeners();
  }
}
