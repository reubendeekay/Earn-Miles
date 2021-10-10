import 'dart:developer';

import 'package:earn_miles/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tiers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          TiersWidgets('Tier 1'),
          TiersWidgets('Tier 2'),
          TiersWidgets('Tier 3'),
        ],
      ),
    );
  }
}

class TiersWidgets extends StatelessWidget {
  final String title;
  TiersWidgets(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Stack(
        children: [
          Image.asset('assets/images/tier.png'),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.coins,
                      color: Colors.amber.shade200,
                      size: 32,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KES0',
                          style: TextStyle(
                              color: Colors.amber.shade200, fontSize: 20),
                        ),
                        Text(
                          'Accumulated task rebates',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.streetView,
                      color: Colors.amber.shade200,
                      size: 32,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KES0',
                          style: TextStyle(
                              color: Colors.amber.shade200, fontSize: 20),
                        ),
                        Text(
                          'Accumulated task rebates',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
