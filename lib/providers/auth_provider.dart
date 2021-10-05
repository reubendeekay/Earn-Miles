import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;

  Future<void> login({String email, String password}) async {
    try {
      final UserCredential _currentUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.user.uid)
          .get();
    } catch (e) {
      Get.showSnackbar(
        GetBar(
          backgroundColor: kPrimaryColor,
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      Future.delayed(Duration(seconds: 2)).then((value) => Get.back());
    }

    notifyListeners();
  }

  Future<void> signUp(
      {String email,
      String password,
      String phoneNumber,
      String invitation}) async {
    final UserCredential _currentUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    String link = 'https://earnmiles.page.link/refer/' +
        phoneNumber.replaceRange(0, 1,
            ''); // it can be any url, it does not have to be an existing one
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix:
          'https://earnmiles.page.link', // uri prefix used for Dynamic Links in Firebase Console
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        packageName: 'com.example.earn_miles', // package name for your app
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
          bundleId: 'com.example.earn_miles'), // bundle ID for your app
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.user.uid)
        .set({
      'userId': _currentUser.user.uid,
      'email': email,
      'referredBy': invitation,
      'invitationCode': phoneNumber.replaceRange(0, 1, ''),
      'referralLink': shortDynamicLink.shortUrl.toString(),
      'password': password,
      'phoneNumber': phoneNumber,
      'withdrawalPin': null,
      'profilePic':
          'https://thumbs.dreamstime.com/b/letter-em-logo-colorful-splash-background-combination-design-creative-industry-web-business-company-203783068.jpg',
      'referralIds': null,
      'loginId': phoneNumber.replaceRange(0, 1, ''),
      'balance': 50.00001,
      'mpesaNumber': null,
      'tier': null,
      'transactions': null,
      'dailyIncome': 0.00001,
      'createdAt': DateTime.now().toIso8601String(),
    });

    notifyListeners();
  }

  Future<void> getCurrentUser(String userId) async {
    final _currentUser =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    _user = UserModel(
      dailyIncome: _currentUser['dailyIncome'],
      email: _currentUser['email'],
      phoneNumber: _currentUser['phoneNumber'],
      password: _currentUser['password'],
      referralLink: _currentUser['referralLink'],
      loginId: _currentUser['loginId'],
      mpesaNumber: _currentUser['mpesaNumber'],
      profilePic: _currentUser['profilePic'],
      referralIds: _currentUser['referralIds'],
      tier: _currentUser['tier'],
      balance: _currentUser['balance'],
      transactions: _currentUser['transactions'],
      userId: _currentUser['userId'],
      withdrawalPin: _currentUser['withdrawalPin'],
      invitationCode: _currentUser['invitationCode'],
      referredBy: _currentUser['referredBy'],
    );

    notifyListeners();
  }
}
