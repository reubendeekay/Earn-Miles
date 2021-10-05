import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/homepage/widgets/assets_home.dart';
import 'package:earn_miles/screens/homepage/widgets/equipment_home.dart';
import 'package:earn_miles/screens/homepage/widgets/headlines_home.dart';
import 'package:earn_miles/screens/homepage/widgets/home_actions.dart';
import 'package:earn_miles/screens/homepage/widgets/home_withdrawal.dart';
import 'package:earn_miles/screens/homepage/widgets/top_images.dart';
import 'package:earn_miles/screens/homepage/widgets/video_tutorial.dart';
import 'package:earn_miles/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  static const routeName = '/homepage';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: user == null
            ? LoadingScreen()
            : ListView(
                children: [
                  TopImages(),
                  AssetsHome(),
                  HomeActions(),
                  EquipmentHome(),
                  HomeWithdrawal(),
                  VideoTutorial(),
                  HeadlinesHome(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }
}
