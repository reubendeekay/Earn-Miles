import 'package:earn_miles/screens/profile/widgets/profile_actions.dart';
import 'package:earn_miles/screens/profile/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            Expanded(child: ProfileActions()),
          ],
        ),
      ),
    );
  }
}
