import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/lipa_na_mpesa.dart';
import 'package:earn_miles/models/transactions_model.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/providers/transaction_provider.dart';
import 'package:earn_miles/screens/transcations/deposit_record.dart';
import 'package:earn_miles/widgets/done_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:earn_miles/main.dart';
import 'package:provider/provider.dart';
import 'package:mpesa/mpesa.dart';

class DepositScreen extends StatelessWidget {
  static const routeName = '/deposit';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Deposit to Balance'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: ListView(
          children: [
            Row(
              children: [
                Text('My balance:  '),
                Text(
                  'KES${user.balance.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DepositCard(user)
          ],
        ),
      ),
    );
  }
}

class DepositCard extends StatefulWidget {
  final UserModel user;
  DepositCard(this.user);
  @override
  _DepositCardState createState() => _DepositCardState();
}

class _DepositCardState extends State<DepositCard> {
  final _formKey = GlobalKey<FormState>();
  String _selectedAmount = '600';
  bool isLoading = false;

  int currentIndex = 0;
  List<String> amounts = [
    '600',
    '1000',
    '5000',
    '10000',
    '20000',
    '50000',
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                'Deposit Amount',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 2.1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: List.generate(
                  amounts.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;

                        _selectedAmount = amounts[index];
                      });
                    },
                    child:
                        selectedAmount(amounts[index], currentIndex == index),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _selectedAmount = value.trim();
                    });
                  },
                  initialValue: _selectedAmount,
                  // controller: TextEditingController(text: _selectedAmount),
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
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  final uid = FirebaseAuth.instance.currentUser.uid;

                  mpesa
                      .lipaNaMpesa(
                    phoneNumber:
                        widget.user.phoneNumber.replaceRange(0, 1, '254'),
                    amount: double.parse(_selectedAmount),
                    businessShortCode: "3027949",
                    accountReference:
                        widget.user.phoneNumber.replaceRange(0, 1, ''),
                    callbackUrl:
                        'https://us-central1-earn-miles.cloudfunctions.net/lmno_callback_url/user?uid=$uid/${int.parse(_selectedAmount)}',
                  )
                      .then((result) async {
                    setState(() {
                      isLoading = false;
                    });
                  }).catchError((error) {
                    setState(() {
                      isLoading = false;
                    });
                    print('ERROR : ' + error.toString());
                  });
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Deposit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                  Navigator.of(context).pushNamed(DepositRecord.routeName);
                },
                child: Text(
                  'Deposit History',
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
              '**Make sure your M-Pesa account has enough balance\n**Pay my own money into balance\n**Note: You shall click again 5 minutes later if the payment interface page hasnt popped up',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedAmount(String amount, bool isSelected) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelected ? kPrimaryColor : Colors.white,
            border:
                isSelected ? null : Border.all(width: 1, color: Colors.grey)),
        child: Center(
          child: Text(
            amount,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : kPrimaryColor),
          ),
        ));
  }
}
