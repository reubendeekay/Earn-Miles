import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/transcations/deposit_screen.dart';
import 'package:earn_miles/screens/transcations/withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentBalace extends StatelessWidget {
  final UserModel user;
  CurrentBalace({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, spreadRadius: 2, color: Colors.black12)
          ]),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your current available account balance is',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'KES',
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                Text(
                  '${user.balance.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DepositScreen.routeName);
                  },
                  color: kPrimaryColor,
                  child: Text(
                    'Deposit',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WithdrawScreen.routeName);
                  },
                  color: Colors.white,
                  child: Text(
                    'Withdraw',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
