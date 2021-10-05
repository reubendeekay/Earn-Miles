import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/custom_video.dart';
import 'package:earn_miles/models/tutorial_model.dart';

import 'package:flutter/material.dart';

class VideoTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Video Tutorial',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Divider(),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('admin')
                  .doc('media')
                  .collection('videos')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('No videos available'),
                    ),
                  );
                } else {
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: docs
                        .map(
                          (e) => CustomVideo(
                            video: TutorialModel(
                              caption: e['caption'],
                              id: e.id,
                              videoUrl: e['videoUrl'],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              })
        ],
      ),
    );
  }
}
