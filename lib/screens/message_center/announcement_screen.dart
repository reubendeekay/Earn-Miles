import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  static const routeName = '/announcement-screen';

  @override
  Widget build(BuildContext context) {
    final message =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement'),
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
                message['title'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(message['message']),
          )
        ],
      ),
    );
  }
}
