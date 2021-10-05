import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
          child: Container(
        child: Text('To be implemented'),
      )),
    );
  }
}
