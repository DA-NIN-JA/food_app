import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
  void addUser(User user) {
    FirebaseFirestore.instance.collection("users").add({
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "imageUrl": user.imageUrl,
      "address": user.address,
    });
  }

  Future<User> getUserInfo() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(userID).get();
    User currentUser = User(
      name: userData["name"],
      email: userData["email"],
      address: userData["address"],
      imageUrl: userData["imageUrl"],
      phone: userData["phone"],
    );

    return currentUser;
  }
}
