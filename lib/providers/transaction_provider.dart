import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/models/user_model.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transcations = [];
  List<TransactionModel> get transactions => [..._transcations];

  Future<void> addTransaction(TransactionModel transaction) async {
    final id = FirebaseFirestore.instance
        .collection('transactions')
        .doc('users')
        .collection(transaction.userId)
        .doc()
        .id;

    await FirebaseFirestore.instance
        .collection('transactions')
        .doc('users')
        .collection(transaction.userId)
        .doc(id)
        .set({
      'transactionId': id,
      'amount': transaction.transactionAmount,
      'status': transaction.transactionStatus,
      'transactionType': transaction.transactionType,
      'transactionDate': transaction.transactionDate,
      'userId': transaction.userId,
    });
    notifyListeners();
  }

  Future<void> requestWithdrwal(
      TransactionModel transaction, UserModel user) async {
    final id = FirebaseFirestore.instance
        .collection('transactions')
        .doc('withdrawal')
        .collection(user.userId)
        .doc()
        .id;

    await FirebaseFirestore.instance
        .collection('transactions')
        .doc('withdrawal')
        .collection(user.userId)
        .doc(id)
        .set({
      'transactionId': id,
      'amount': transaction.transactionAmount,
      'status': transaction.transactionStatus,
      'transactionDate': transaction.transactionDate,
      'userId': user.userId,
      'profilePic': user.profilePic,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'createdAt': Timestamp.now(),
    });
       FirebaseFirestore.instance.collection('transactions')
                    .doc('withdrawal')
                    .collection('requests').doc()
                         .set({

      'amount': transaction.transactionAmount,
      'status': transaction.transactionStatus,
      'transactionDate': transaction.transactionDate,
      'userId': user.userId,
      'profilePic': user.profilePic,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'createdAt': Timestamp.now(),
    });

    notifyListeners();
  }
}
