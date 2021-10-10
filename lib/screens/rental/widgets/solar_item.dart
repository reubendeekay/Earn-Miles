import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/solar_model.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/providers/general_provider.dart';
import 'package:earn_miles/screens/rental/rental_details.dart';
import 'package:earn_miles/screens/transcations/deposit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SolarItem extends StatelessWidget {
  final SolarModel solar;
  SolarItem({
    this.solar,
  });
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(RentalDetails.routeName, arguments: solar),
      child: Container(
        width: double.infinity,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 3,
            color: Colors.grey.withOpacity(0.1),
          )
        ]),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topSolarItem(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: kPrimaryColor.withOpacity(0.15)),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily income(KES)',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${NumberFormat.simpleCurrency(
                          locale: 'en_US',
                          name: '',
                        ).format(solar.dailyIncome)}',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),

                      Text(
                        'Total income(KES)',
                        style: TextStyle(fontSize: 12),
                      ),
                      // SizedBox(height: 10),
                      Text(
                        '${NumberFormat.simpleCurrency(
                          locale: 'en_US',
                          name: '',
                        ).format(solar.dailyIncome * 90)}',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      if (user.balance < solar.price) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Insuffient balance')));
                        Future.delayed(Duration(seconds: 1)).then((_) {
                          Navigator.of(context)
                              .pushNamed(DepositScreen.routeName);
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text('Confirm Payment'),
                                    content: Text(
                                        'Are you sure you want to pay KES${solar.price} for this solar panel?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            await Provider.of<GeneralProvider>(
                                                    context,
                                                    listen: false)
                                                .purchaseSolar(solar, user);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Successfuly Purchased')));
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Confirm')),
                                    ]));
                      }
                    },
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Text(
                          'Lease',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container topSolarItem() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SolarIcon(),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(solar.type),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${solar.price.toStringAsFixed(0)}',
                    style: TextStyle(
                        fontSize: 24,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' KES/90 Days',
                    style: TextStyle(color: kPrimaryColor),
                  )
                ],
              ),
              Text('Stock:${solar.stock}')
            ],
          )
        ],
      ),
    );
  }
}

class SolarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 50,
      child: Lottie.asset('assets/solar.json', fit: BoxFit.fitHeight),
    );
  }
}
