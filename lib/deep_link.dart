import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<void> createDeepLink() async {
  String link = 'https://earnmiles.page.link/refer/' +
      '796660187'; // it can be any url, it does not have to be an existing one
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
}
