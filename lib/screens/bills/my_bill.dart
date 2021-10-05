import 'package:earn_miles/constants.dart';
import 'package:earn_miles/screens/bills/all_bills.dart';
import 'package:earn_miles/screens/bills/bill_deposit.dart';
import 'package:earn_miles/screens/bills/bill_withdrawal.dart';
import 'package:flutter/material.dart';

class MyBill extends StatelessWidget {
  static const routeName = 'my_bill';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              title: Text('My Bill'),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              elevation: 0,
              bottom: TabBar(
                labelColor: Colors.amber,
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey.shade100),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                isScrollable: true,
                indicatorColor: Colors.amber,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('All'),
                  ),
                  Tab(
                    child: Text('Referral'),
                  ),
                  Tab(
                    child: Text('Deposit'),
                  ),
                  Tab(
                    child: Text('Withdrawal'),
                  ),
                ],
              )),
          body: TabBarView(children: [
            AllBills(),
            Container(),
            BillDeposit(),
            BillWithdrawal(),
          ]),
        ));
  }
}

class BillAccumulated extends StatelessWidget {
  final String title;
  final String amount;
  BillAccumulated({this.amount, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            'KES$amount',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
