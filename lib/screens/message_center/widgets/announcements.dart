import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/screens/message_center/announcement_screen.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Announcements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('announcements')
              .orderBy('createdAt')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: NotFound());
            } else {
              List<DocumentSnapshot> docs = snapshot.data.docs;
              return ListView(
                shrinkWrap: true,
                children: docs
                    .map((e) => AnnouncementTile(
                          time: e['createdAt'],
                          title: e['title'],
                          message: e['message'],
                        ))
                    .toList(),
              );
            }
          },
        ));
  }
}

class AnnouncementTile extends StatelessWidget {
  final String title;
  final Timestamp time;
  final String message;

  AnnouncementTile({this.time, this.title, this.message});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(AnnouncementScreen.routeName, arguments: {
        'title': title,
        'time': time,
        'message': message,
      }),
      child: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              DateFormat('yyyy-MM-dd HH:mm').format(time.toDate()),
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
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
