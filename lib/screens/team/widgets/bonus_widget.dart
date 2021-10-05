import 'package:flutter/material.dart';

class BonusWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(vertical: 2.5),
        child: Image.asset(
          'assets/images/refer.png',
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ));
  }
}
