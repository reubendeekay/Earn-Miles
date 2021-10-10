import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawRecord extends StatelessWidget {
  static const routeName = '/withdraw-record';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Withdrawal record'),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('transactions')
              .doc('withdrawal')
              .collection(FirebaseAuth.instance.currentUser.uid)
              .orderBy('createdAt')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(
                child: NotFound(),
              );
            } else {
              List<DocumentSnapshot> docs = snapshot.data.docs;
              return ListView(
                children: docs
                    .map((e) => WithdrawalRecordTile(
                          amount: double.parse(e['amount']),
                          status: e['status'],
                          transDate: e['createdAt'],
                          transId: e.id,
                        ))
                    .toList(),
              );
            }
          },
        ));
  }
}

class WithdrawalRecordTile extends StatelessWidget {
  final double amount;

  final Timestamp transDate;

  final bool status;
  final String transId;

  const WithdrawalRecordTile({
    Key key,
    this.amount,
    this.transId,
    this.status,
    this.transDate,
  }) : super(key: key);

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
                status ? 'Approved' : 'Waiting review',
                style: TextStyle(color: !status ? Colors.red : Colors.green),
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
                color: !status ? Colors.red : Colors.green,
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
                DateFormat('yyyy-MM-dd HH:mm:ss').format(transDate.toDate()),
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
            color: Colors.grey[300],
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              'Once approved, the total amount of money that will be credited to your account will be ${amount * 0.9}',
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
          )
        ],
      ),
    );
  }
}
