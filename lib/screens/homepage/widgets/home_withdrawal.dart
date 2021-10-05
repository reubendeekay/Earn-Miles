import 'package:earn_miles/screens/rental/rental_screen.dart';
import 'package:earn_miles/screens/transcations/withdrawal_proofs.dart';
import 'package:flutter/material.dart';

class HomeWithdrawal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          item('Withdrawal Proof/Alert (Updated Everyday)', 'gift_orange.png',
              context, WithdrawalProofs.routeName),
          SizedBox(width: 10),
          item(
              'Rental Hall', 'rentalhall.png', context, RentalScreen.routeName),
        ],
      ),
    );
  }

  Widget item(
      String title, String image, BuildContext context, String routeName) {
    return Expanded(
      child: Container(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(routeName),
          child: Stack(
            children: [
              Image.asset('assets/images/$image'),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
