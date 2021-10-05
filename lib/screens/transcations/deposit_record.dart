import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/transactions_model.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositRecord extends StatelessWidget {
  static const routeName = '/deposit-record';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Recharge record'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .doc('users')
                  .collection(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.hasError ||
                    snapshot.data == null) {
                  return Container();
                } else {
                  List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: documents
                          .map((e) => DepositRecordTile(
                                TransactionModel(
                                  transactionDate: e['date'],
                                  userId: e['userId'],
                                  transactionId: e['transactionId'],
                                  transactionAmount: e['amount'],
                                  transactionType: e['transactionType'],
                                  transactionStatus: e['status'],
                                ),
                              ))
                          .toList());
                }
              },
            )
          ],
        ));
  }
}

class DepositRecordTile extends StatelessWidget {
  final TransactionModel transaction;
  DepositRecordTile(this.transaction);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Payment amount'),
              Spacer(),
              Text(
                transaction.transactionStatus,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'KES${transaction.transactionAmount}',
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Creation date:  ',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                DateFormat('yyyy-MM-ddd HH::mm:ss')
                    .format(transaction.transactionDate.toDate()),
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.5,
          ),
          Row(
            children: [
              Text(
                'Payment order:  ',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                transaction.transactionId,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.yellow.withOpacity(0.2),
            padding: EdgeInsets.all(10),
            child: Text(
              '''You have tried to deposit the amount to SolarDream, but it was failed, because you haven't completed all the payment steps successfully through M-Pesa checkout. Therefore, the amount hasn't been deducted from your M-Pesa account, you shall check the transaction details through your M-Pesa account, Please contact customer service if you feel the need.''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
