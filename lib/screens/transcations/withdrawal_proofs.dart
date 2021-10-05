import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/proof_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawalProofs extends StatelessWidget {
  static const routeName = '/withdrawal-proofs';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal Proofs'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      dateContainer(title: 'Starting date'),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      dateContainer(title: 'Ending date'),
                    ],
                  ),
                  phoneContainer('Phone number'),
                  searchButton(size)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('testimonials')
                  .orderBy('date')
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Container(
                    height: 100,
                  );
                } else {
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: docs
                        .map((e) => WithdrawProofTile(
                              proof: ProofModel(
                                  phoneNumber: e['phoneNumber'],
                                  date: e['date'].toDate(),
                                  id: e.id,
                                  imageUrl: e['image'],
                                  profilePic: e['profilePic'],
                                  description: e['comment']),
                            ))
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget searchButton(Size size) {
    return Container(
      height: 50,
      width: size.width,
      child: RaisedButton(
        onPressed: () {},
        color: kPrimaryColor,
        child: Text(
          'Search',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget phoneContainer(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Enter phone number',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15)),
      ),
    );
  }

  Widget dateContainer({String title, String date}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        height: 45,
        child: date != null
            ? Text(date)
            : Text(
                title,
                style: TextStyle(color: Colors.grey),
              ),
      ),
    );
  }
}

class WithdrawProofTile extends StatelessWidget {
  final ProofModel proof;
  WithdrawProofTile({this.proof});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://icon-library.com/images/contact-icon-png/contact-icon-png-5.jpg')),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proof.phoneNumber.replaceRange(6, 10, '****'),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  DateFormat('yyyy-MM-dd  HH:mm:ss').format(proof.date),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Container(
                  child: Text(
                    proof.description,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 150,
                  color: kPrimaryColor,
                  child: Image.network(
                    proof.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
