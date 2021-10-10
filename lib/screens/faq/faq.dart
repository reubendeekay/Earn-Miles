import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/screens/faq/faq_details.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FAQ extends StatefulWidget {
  static const String routeName = '/FAQ';

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final _formKey = GlobalKey<FormState>();

  String searchTerm;
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Frequently Asked Questions')),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: size.width,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            searchTerm = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Search a question',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate())
                        setState(() {
                          isSearch = true;
                        });
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (!isSearch || searchTerm == null)
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('faq')
                    .orderBy('createdAt')
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: NotFound());
                  } else {
                    List<DocumentSnapshot> e = snapshot.data.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => FAQTile(
                        date: e[i]['createdAt'],
                        index: '${i + 1}',
                        title: e[i]['question'],
                        answer: e[i]['answer'],
                      ),
                      itemCount: e.length,
                    );
                  }
                },
              ),
            if (isSearch && searchTerm != null)
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('faq')
                    .where('question', isLessThanOrEqualTo: searchTerm)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: NotFound());
                  } else {
                    List<DocumentSnapshot> e = snapshot.data.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => FAQTile(
                        date: e[i]['createdAt'],
                        index: '${i + 1}',
                        title: e[i]['question'],
                        answer: e[i]['answer'],
                      ),
                      itemCount: e.length,
                    );
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String title;
  final String answer;
  final String index;
  final Timestamp date;
  FAQTile({this.date, this.title, this.answer, this.index});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(FaqDetails.routeName, arguments: {
        'title': title,
        'answer': answer,
        'date': date,
      }),
      child: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$index. $title',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(date.toDate()),
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
