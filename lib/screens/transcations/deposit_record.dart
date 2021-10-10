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
                  .doc('deposit')
                  .collection(FirebaseAuth.instance.currentUser.uid)
                  .orderBy('checkoutRequestID', descending: true)
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
                                amount: double.parse(e['amount']),
                                description: e['resultDesc'],
                                mpesaReceipt: e['merchantRequestID'],
                                // status: e['confirmed'],
                                // transDate: e['transactionDate'],
                                resultCode: e['resultCode'],
                                transId: e.id,
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
  final double amount;
  final String description;
  final int transDate;
  final String mpesaReceipt;
  final String status;
  final String transId;
  final int resultCode;

  const DepositRecordTile(
      {Key key,
      this.amount,
      this.resultCode,
      this.transId,
      this.status,
      this.description,
      this.transDate,
      this.mpesaReceipt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = transDate == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(transDate);
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
                resultCode != 0 ? 'Failed' : 'Status',
                style: TextStyle(
                    color: resultCode != 0 ? Colors.red : Colors.green),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            // 'KES${transaction.transactionAmount}',
            'KES${amount.toStringAsFixed(0)}',
            style: TextStyle(
                fontSize: 18,
                color: resultCode != 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold),
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
                DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
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
                transId,
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
            color: resultCode != 0
                ? Colors.yellow.withOpacity(0.2)
                : Colors.green.withOpacity(0.2),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              description == null ? 'Failed to deposit' : '$description',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: resultCode != 0 ? Colors.red : Colors.green),
            ),
          )
        ],
      ),
    );
  }
}
