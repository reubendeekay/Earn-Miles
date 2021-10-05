import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/wallet/widgets/account_number.dart';
import 'package:earn_miles/screens/wallet/widgets/current_balance.dart';
import 'package:earn_miles/screens/wallet/widgets/other_balances.dart';
import 'package:earn_miles/screens/wallet/widgets/wallet_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // height: size.height * 0.48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CurrentBalace(
                    user: user,
                  ),
                  OtherBalances(
                    user: user,
                  ),
                  AccountNumber(
                    user: user,
                  ),
                ],
              ),
            ),
            WalletOptions(),
          ],
        ),
      ),
    );
  }
}
