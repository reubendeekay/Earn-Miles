import 'package:earn_miles/models/user_model.dart';
import 'package:flutter/material.dart';

class OtherBalances extends StatelessWidget {
  final UserModel user;
  OtherBalances({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildBalance(title: 'Todays\n total revenue', number: 'KES0'),
          buildBalance(
            title: 'Number of referrals\nin Tier 1,2,3',
            number: '0',
          ),
          buildBalance(
              title: 'Accumulated revenue\n from referrals', number: '0'),
        ],
      ),
    );
  }

  Widget buildBalance({String title, String number}) {
    return Container(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                color: Colors.amber[400],
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          )
        ],
      ),
    );
  }
}
