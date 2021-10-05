import 'package:earn_miles/constants.dart';
import 'package:earn_miles/screens/auth_screen.dart';
import 'package:earn_miles/screens/faq/faq.dart';
import 'package:earn_miles/screens/settings/about_us.dart';
import 'package:earn_miles/screens/settings/change_password.dart';
import 'package:earn_miles/screens/settings/change_withdrawal_pin.dart';
import 'package:earn_miles/screens/settings/customer-service.dart';
import 'package:earn_miles/screens/settings/feedback_form.dart';
import 'package:earn_miles/screens/settings/privacy_policy.dart';
import 'package:earn_miles/screens/settings/terms_of_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 2.0,
          children: [
            ProfileActionsTile(
              title: 'Customer\n Service',
              icon: FontAwesomeIcons.headset,
              routeName: CustomerService.routeName,
            ),
            ProfileActionsTile(
              title: 'Change \nPassword',
              icon: Icons.lock_outline,
              routeName: ChangePasswordScreen.routeName,
            ),
            ProfileActionsTile(
              title: 'Change Withdrawal\n security pin',
              icon: Icons.verified_user_outlined,
              routeName: ChangeWithdrawalPinScreen.routeName,
            ),
            ProfileActionsTile(
              title: 'Feedback and\n complaint',
              icon: FontAwesomeIcons.commentDots,
              routeName: FeedbackComplaintScreen.routeName,
            ),
            ProfileActionsTile(
              title: 'Frequently asked\n questions',
              icon: FontAwesomeIcons.questionCircle,
              routeName: FAQ.routeName,
            ),
            ProfileActionsTile(
              title: 'About\n us',
              icon: Icons.info_outline,
              routeName: AboutUs.routeName,
            ),
            ProfileActionsTile(
              title: 'Terms of Service',
              icon: Icons.article_outlined,
              routeName: TermsofService.routeName,
            ),
            ProfileActionsTile(
              title: 'Privacy policy',
              icon: FontAwesomeIcons.fingerprint,
              routeName: PrivacyPolicy.routeName,
            ),
            GestureDetector(
              onTap: () => {FirebaseAuth.instance.signOut()},
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 28,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Log out',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

class ProfileActionsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String routeName;
  ProfileActionsTile({this.title, this.icon, this.routeName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
