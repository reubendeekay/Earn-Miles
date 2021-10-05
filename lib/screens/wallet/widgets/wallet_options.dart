import 'package:earn_miles/constants.dart';
import 'package:earn_miles/screens/bills/my_bill.dart';
import 'package:earn_miles/screens/transcations/deposit_record.dart';
import 'package:earn_miles/screens/transcations/withdrawal_proofs.dart';
import 'package:earn_miles/screens/transcations/withdrawal_record.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(WithdrawalProofs.routeName),
            child: buildOption(
              'Withdrawal alert from all members',
            ),
          ),
          Divider(),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(MyBill.routeName),
              child: buildOption('My Bill')),
          Divider(),
          GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(DepositRecord.routeName),
              child: buildOption('Deposit record')),
          Divider(),
          GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(WithdrawRecord.routeName),
              child: buildOption('Withdrawal record')),
        ],
      ),
    );
  }

  Widget buildOption(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.moneyBillAlt,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
