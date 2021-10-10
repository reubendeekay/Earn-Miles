import 'package:cloud_firestore/cloud_firestore.dart';

class SolarModel {
  final String type;
  final int price;
  final double dailyIncome;
  final double totalIncome;
  final int stock;
  final Timestamp purchasedAt;

  SolarModel(
      {this.type,
      this.purchasedAt,
      this.price,
      this.dailyIncome,
      this.totalIncome,
      this.stock});
}
