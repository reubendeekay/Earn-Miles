import 'package:earn_miles/screens/bills/my_bill.dart';
import 'package:flutter/material.dart';

class BillDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          BillAccumulated(
            amount: '0',
            title: 'Accumulated deposit amount',
          ),
        ],
      ),
    );
  }
}
