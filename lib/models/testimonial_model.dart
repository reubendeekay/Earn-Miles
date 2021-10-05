import 'package:cloud_firestore/cloud_firestore.dart';

class TestimonialModel {
  final String name;
  final String image;
  final String comment;
  final Timestamp date;
  final String phoneNumber;
  final String profilePic;
  final String testimonialId;

  TestimonialModel({
    this.name,
    this.image,
    this.comment,
    this.date,
    this.phoneNumber,
    this.profilePic,
    this.testimonialId,
  });
}
