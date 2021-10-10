import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/deep_link.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/providers/transaction_provider.dart';
import 'package:earn_miles/screens/transcations/withdrawal_record.dart';
import 'package:earn_miles/widgets/done_icon.dart';
import 'package:flutter/material.dart';

import 'package:earn_miles/constants.dart';
import 'package:provider/provider.dart';

class WithdrawScreen extends StatelessWidget {
  static const routeName = '/withdraw';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Online withdraw'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: ListView(
          children: [
            Row(
              children: [
                Text('My balance:  '),
                Text(
                  'KES${user.balance.toStringAsFixed(0)}',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            WithdrawCard()
          ],
        ),
      ),
    );
  }
}

class WithdrawCard extends StatefulWidget {
  @override
  _WithdrawCardState createState() => _WithdrawCardState();
}

class _WithdrawCardState extends State<WithdrawCard> {
  int _selectedAmount = 200;
  String whatsappNumber;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Enter the apply amount',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _selectedAmount = int.parse(value);
                    });
                  },
                  validator: (val) {
                    if (int.parse(val) < 100) {
                      return 'Cannot withdraw less than 100';
                    }
                    if (int.parse(val) % 100 > 0) {
                      return 'You can only withdraw in multiples of 100';
                    }
                    return null;
                  },
                  initialValue: _selectedAmount.toString(),
                  style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixText: 'KES',
                    prefixStyle: TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Enter the whatsapp number',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      whatsappNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your whatsapp number';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: 'Enter the your whatsapp number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    if (_formKey.currentState.validate() &&
                        user.balance > _selectedAmount) {
                      await Provider.of<TransactionProvider>(context,
                              listen: false)
                          .requestWithdrwal(
                              TransactionModel(
                                  transactionAmount: _selectedAmount.toString(),
                                  // transactionDate: Timestamp.now(),
                                  transactionStatus: false),
                              user);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          content: DoneIcon(),
                        ),
                      );
                      Future.delayed(Duration(milliseconds: 2500))
                          .then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Insufficient balance')));
                    }
                  },
                  child: Text(
                    'Withdraw',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  color: kPrimaryColor,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: kPrimaryColor, width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WithdrawRecord.routeName);
                  },
                  child: Text(
                    'Withdrawal History',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  textColor: kPrimaryColor,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'After the platform approval, the money will be transferred to the M-Pesa account bound to your registered number',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }
}
