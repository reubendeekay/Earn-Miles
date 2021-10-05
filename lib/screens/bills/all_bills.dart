import 'package:earn_miles/screens/bills/my_bill.dart';
import 'package:flutter/material.dart';

class AllBills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          BillAccumulated(
            title: 'Accumulated revenue from all items',
            amount: '50',
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
