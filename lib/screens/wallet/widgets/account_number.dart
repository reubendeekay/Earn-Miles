import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:flutter/material.dart';

class AccountNumber extends StatelessWidget {
  final UserModel user;
  AccountNumber({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Colors.amber.shade100,
            Colors.amber.shade300,
            Colors.amber.shade400,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    'Mpesa account number',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(
                    Icons.edit_rounded,
                    color: kPrimaryColor,
                  )
                ],
              ),
              Text(
                user.phoneNumber,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'Account owner',
                style: TextStyle(fontSize: 14),
              ),
            ],
          )),
    );
  }
}
