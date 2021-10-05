import 'package:earn_miles/screens/team/widgets/accumulated_widget.dart';
import 'package:earn_miles/screens/team/widgets/bonus_widget.dart';
import 'package:earn_miles/screens/team/widgets/invitation_widget.dart';
import 'package:earn_miles/screens/team/widgets/team_screen_top.dart';
import 'package:earn_miles/screens/team/widgets/tiers_widgets.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            TeamScreenTop(),
            AccumulatedWidget(),
            BonusWidgets(),
            InvitationLinks(),
            Tiers(),
          ],
        ),
      ),
    );
  }
}
