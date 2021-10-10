import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/solar_model.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MySolars extends StatelessWidget {
  static const routeName = 'my-solars';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Solars'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: user.solars.map((e) => MySolarItem(e)).toList(),
      ),
    );
  }
}

class MySolarItem extends StatelessWidget {
  final SolarModel solar;
  MySolarItem(this.solar);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          topSolarItem(),
          Divider(),
        ],
      ),
    );
  }

  Container topSolarItem() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        // color: Colors.white,
      ),
      child: Row(
        children: [
          SolarIcon(),
          SizedBox(width: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(solar.type),
              Text(
                'Daily Income: ${solar.dailyIncome.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Purchased at: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(solar.purchasedAt.toDate())}',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Remaining days: ${90 - (DateTime.now().difference(solar.purchasedAt.toDate()).inDays)} days')
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
