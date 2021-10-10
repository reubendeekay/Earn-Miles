import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/models/social_group_model.dart';
import 'package:earn_miles/models/solar_model.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class GeneralProvider with ChangeNotifier {
  List<SocialGroupModel> _waService = [];
  List<SocialGroupModel> _waMembers = [];
  List<SocialGroupModel> _tgService = [];
  List<SocialGroupModel> _tgMembers = [];
  List<SocialGroupModel> get waService => [..._waService];
  List<SocialGroupModel> get waMembers => [..._waMembers];
  List<SocialGroupModel> get tgService => [..._tgService];
  List<SocialGroupModel> get tgMembers => [..._tgMembers];

  Future<void> getGroups() async {
    final waServiceData = await FirebaseFirestore.instance
        .collection('groups')
        .doc('links')
        .collection('waService')
        .get();
    final waMembersData = await FirebaseFirestore.instance
        .collection('groups')
        .doc('links')
        .collection('waMembers')
        .get();
    final tgServiceData = await FirebaseFirestore.instance
        .collection('groups')
        .doc('links')
        .collection('tgService')
        .get();
    final tgMembersData = await FirebaseFirestore.instance
        .collection('groups')
        .doc('links')
        .collection('tgMembers')
        .get();

    _waService = waServiceData.docs
        .map((e) => SocialGroupModel(
            category: e['category'],
            id: e.id,
            link: e['link'],
            name: e['name']))
        .toList();
    _waMembers = waMembersData.docs
        .map((e) => SocialGroupModel(
            category: e['category'],
            id: e.id,
            link: e['link'],
            name: e['name']))
        .toList();
    _tgService = tgServiceData.docs
        .map((e) => SocialGroupModel(
            category: e['category'],
            id: e.id,
            link: e['link'],
            name: e['name']))
        .toList();
    _tgMembers = tgMembersData.docs
        .map((e) => SocialGroupModel(
            category: e['category'],
            id: e.id,
            link: e['link'],
            name: e['name']))
        .toList();

    notifyListeners();
  }

  Future<void> purchaseSolar(SolarModel solar, UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'balance': user.balance - solar.price,
      'dailyIncome': solar.dailyIncome + user.dailyIncome,
      'solars': FieldValue.arrayUnion([
        {
          'package': solar.type,
          'purchasedAt': Timestamp.now(),
          'dailyIncome': solar.dailyIncome,
        }
      ])
    });
    final referred = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.referredBy)
        .get();
    final referredDailyIncome = referred['dailyIncome'];
    final initialUser = referred['referredBy'];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.referredBy)
        .update({
      'dailyIncome': referredDailyIncome + (solar.dailyIncome * 0.1),
    });

    final initialReferee = await FirebaseFirestore.instance
        .collection('users')
        .doc(initialUser)
        .get();
    final initialRefereeDailyIncome = initialReferee['dailyIncome'];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(initialUser)
        .update({
      'dailyIncome': initialRefereeDailyIncome + (solar.dailyIncome * 0.05),
    });
  }
}
