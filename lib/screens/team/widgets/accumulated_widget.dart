import 'package:earn_miles/constants.dart';
import 'package:flutter/material.dart';

class AccumulatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      margin: EdgeInsets.symmetric(vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'KES0',
                    style:
                        TextStyle(fontSize: 20, color: Colors.amber.shade200),
                  ),
                  Text(
                    'Accumulated\n referral rebates',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0  ',
                          style: TextStyle(fontSize: 20, color: kPrimaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14,
                        )
                      ],
                    ),
                    Text(
                      'My referrals\n in Tier One',
                      style: TextStyle(color: kPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
