import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/bills/my_bill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllBills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Container(
      child: ListView(
        children: [
          BillAccumulated(
            title: 'Accumulated revenue from all items',
            amount: '${user.balance.toStringAsFixed(0)}',
          ),
          BillItem(),
        ],
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Registration give-away',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'KES50',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '2021-09-22 22:56:21',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
