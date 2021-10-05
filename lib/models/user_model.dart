import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String withdrawalPin;
  final String mpesaNumber;
  final String tier;
  final List<String> referralIds;
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
      this.withdrawalPin,
      this.mpesaNumber,
      this.transactions,
      this.dailyIncome,
      this.tier,
      this.referralIds,
      this.invitationCode,
      this.referredBy});
}

class TransactionModel {
  final String transactionId;
  final String transactionType;
  final String transactionAmount;
  final Timestamp transactionDate;
  final String transactionStatus;
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
