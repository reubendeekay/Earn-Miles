import 'package:flutter/material.dart';

class FaqDetails extends StatelessWidget {
  static const routeName = 'faq-details';
  @override
  Widget build(BuildContext context) {
    final answer =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer to the question'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: size.width,
            child: Center(
              child: Text(
                answer['title'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(answer['answer']),
          )
        ],
      ),
    );
  }
}
