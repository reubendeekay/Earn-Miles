import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/models/solar_model.dart';

class UserModel {
  final String phoneNumber;
  final String invitationCode;
  final String referralLink;
  final String referredBy;
  final String userId;
  final String email;
  final String loginId;
  final String profilePic;
  final double balance;
  final String password;

  List<SolarModel> solars;
  final List<dynamic> referrals;
  final List<TransactionModel> transactions;
  final double dailyIncome;

  UserModel(
      {this.phoneNumber,
      this.referralLink,
      this.userId,
      this.email,
      this.loginId,
      this.profilePic,
      this.balance,
      this.password,
      this.transactions,
      this.dailyIncome,
      this.solars,
      this.referrals,
      this.invitationCode,
      this.referredBy});
}

class ReferralModel {
  final String userId;
  final double dailyIncome;
  final String packageName;
  List<ReferralModel> referrals;

  ReferralModel(
      {this.userId, this.dailyIncome, this.packageName, this.referrals});
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'dailyIncome': dailyIncome,
      'packageName': packageName,
      'referrals': referrals,
    };
  }
}

class TransactionModel {
  final String transactionId;
  final String transactionType;
  final String transactionAmount;
  final int transactionDate;
  final bool transactionStatus;
  final String userId;

  TransactionModel(
      {this.transactionId,
      this.transactionType,
      this.userId,
      this.transactionAmount,
      this.transactionDate,
      this.transactionStatus});

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'transactionType': transactionType,
      'transactionAmount': transactionAmount,
      'transactionDate': transactionDate,
      'transactionStatus': transactionStatus
    };
  }
}
