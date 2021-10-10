import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/models/solar_model.dart';
import 'package:earn_miles/screens/rental/my_solars.dart';
import 'package:earn_miles/screens/rental/widgets/solar_item.dart';
import 'package:earn_miles/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RentalScreen extends StatelessWidget {
  static const routeName = '/rental-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Rental Hall'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(MySolars.routeName),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text('My Solars')),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('solars')
            .orderBy('price')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingScreen(),
            );
          } else {
            List<DocumentSnapshot> docs = snapshot.data.docs;
            return ListView(
              children: docs
                  .map((e) => SolarItem(
                        solar: SolarModel(
                          dailyIncome: e['dailyIncome'],
                          price: e['price'],
                          stock: e['stock'],
                          type: e['name'],
                        ),
                      ))
                  .toList(),
            );
          }
        },
      )),
    );
  }
}
