import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/screens/message_center/widgets/announcements.dart';
import 'package:earn_miles/widgets/not_found.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('announcements')
              .doc('messageCenter')
              .collection(FirebaseAuth.instance.currentUser.uid)
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
