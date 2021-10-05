import 'package:earn_miles/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerService extends StatelessWidget {
  static const routeName = '/customer-service';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Service'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GroupCategory(
            title: 'WhatsApp Customer Service List',
          ),
          GroupCategory(
            title: 'Telegram Members\' Groups List',
          ),
          GroupCategory(
            title: 'Whatsapp Members\' Groups List',
          ),
          GroupCategory(
            title: 'Telegram Customer Service List',
          ),
        ],
      ),
    );
  }
}

class GroupCategory extends StatelessWidget {
  final String title;
  GroupCategory({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              height: 20,
              width: 5,
              color: Colors.amber[200],
            ),
            SizedBox(
              width: 8,
            ),
            Text(title),
          ],
        ),
        children: [
          GroupItem(),
          GroupItem(),
          GroupItem(),
          GroupItem(),
          GroupItem(),
        ],
      ),
    );
  }
}

class GroupItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(
            'https://api.whatsapp.com/send/?phone=254796660187&text&app_absent=0');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.headset_mic,
              color: Colors.amber,
            ),
            SizedBox(width: 10),
            Expanded(
                child: Container(
                    child: Text(
                        'WhatsApp Service 5(Working hours :10:00 am to 10:00 pm)')))
          ],
        ),
      ),
    );
  }
}
