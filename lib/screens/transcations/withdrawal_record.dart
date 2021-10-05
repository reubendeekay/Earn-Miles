import 'package:earn_miles/constants.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:flutter/material.dart';

class WithdrawRecord extends StatelessWidget {
  static const routeName = '/withdraw-record';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Withdrawal record'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Center(child: NotFound())]));
  }
}
