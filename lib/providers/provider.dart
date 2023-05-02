import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

class NGO {
  final String name;
  final String description;
  final String address;
  final String cause;

  NGO({
    required this.name,
    required this.address,
    required this.cause,
    required this.description,
  });
}

class NGOProvider with ChangeNotifier {
  List<NGO> _listNGOs = [];

  List<NGO> get listNGOs {
    return [..._listNGOs];
  }

  Future<List<NGO>> getListNGOs() async {
    try {
      List<NGO> _temp = [];
      final snapshot = await FirebaseFirestore.instance.collection("NGO").get();
      for (var doc in snapshot.docs) {
        final singleNGO = NGO(
          name: doc["Name"],
          address: doc["Address"],
          cause: doc["Cause"],
          description: doc["Description"],
        );
        // print(singleNGO.name);
        _temp.add(singleNGO);
        _listNGOs = _temp;
      }
      notifyListeners();
      return _listNGOs;
    } on PlatformException catch (e) {
      rethrow;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void addNGO(NGO ngo) {
    try {
      FirebaseFirestore.instance.collection("NGO").doc().set({
        "Name":ngo.name,
        "Address":ngo.address,
        "Cause":ngo.cause,
        "Description":ngo.description,
      });
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }
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

  Future<User> getUserInfo() async {
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
      rethrow;
    } catch (error) {
      print(error);
      rethrow;
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
    getUserInfo();
    notifyListeners();
  }

  void addDonationTransaction(String phone, String address) {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance
          .collection("users/history/${userId}")
          .doc()
          .set({
        "phone": phone,
        "address": address,
        "Date": DateTime.now(),
        "total": 50,
      });
    } on PlatformException catch (e) {
      print(e);
      rethrow;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}

class DonationData {
  final String address;
  final String total;
  final String id;
  final DateTime date;

  DonationData({
    required this.address,
    required this.id,
    required this.date,
    required this.total,
  });
}

class HistoryProvider with ChangeNotifier {
  List<DonationData> _listDonation = [];

  Future<List<DonationData>> getListDonations() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      List<DonationData> _temp = [];
      final snapshot = await FirebaseFirestore.instance
          .collection("users/history/$userId")
          .get();
      for (var doc in snapshot.docs) {
        final singleDonation = DonationData(
          address: doc["address"],
          id: doc.id.substring(0, 8),
          date: (doc["Date"]as Timestamp).toDate(),
          total: doc["total"].toString(),
        );
        // print(singleNGO.name);
        _temp.add(singleDonation);
        _listDonation = _temp;
      }
      notifyListeners();
      return _listDonation;
    } on PlatformException catch (e) {
      rethrow;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
