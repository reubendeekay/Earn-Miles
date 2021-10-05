import 'package:earn_miles/constants.dart';
import 'package:earn_miles/screens/message_center/widgets/announcements.dart';
import 'package:earn_miles/screens/message_center/widgets/messages.dart';
import 'package:flutter/material.dart';

class MessageCenterScreen extends StatelessWidget {
  static const routeName = '/message-center-screen';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text('Message Center'),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              elevation: 0,
              bottom: TabBar(
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey.shade100),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                isScrollable: true,
                indicatorColor: kPrimaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text('Announcements'),
                  ),
                  Tab(
                    child: Text('Messages'),
                  ),
                ],
              )),
          body: TabBarView(children: [
            Announcements(),
            Messages(),
          ]),
        ));
  }
}
