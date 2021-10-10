import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/providers/general_provider.dart';
import 'package:earn_miles/screens/homepage/home_page.dart';
import 'package:earn_miles/screens/profile/profile_screen.dart';
import 'package:earn_miles/screens/rental/rental_screen.dart';
import 'package:earn_miles/screens/team/team_screen.dart';
import 'package:earn_miles/screens/wallet/wallet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MyNav extends StatefulWidget {
  static const routeName = '/my-nav';

  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context)
        .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
    Provider.of<GeneralProvider>(context).getGroups();

    return Scaffold(
      body: WillPopScope(
          child: _screens[_selectedIndex],
          onWillPop: () async {
            if (_selectedIndex != 0) {
              setState(() {
                _selectedIndex = 0;
              });
            } else {
              return Future.value(true);
            }
          }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: kPrimaryColor,
              // iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.grey,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.shopping_bag_outlined,
                  text: 'Rental',
                ),
                GButton(
                  icon: Icons.people_alt_outlined,
                  text: 'Team',
                ),
                GButton(
                  icon: Icons.account_balance_wallet_outlined,
                  text: 'Wallet',
                ),
                GButton(
                  icon: Icons.person_outline_outlined,
                  text: 'Me',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  List _screens = [
    Homepage(),
    RentalScreen(),
    TeamScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];
}
