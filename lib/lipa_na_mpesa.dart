// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// Future<void> lipaNaMpesa({
//   @required String phoneNumber,
//   String paybill,
//   @required String amount,
//   String accountReference,
//   String passKey,
//   String description,
//   @required String loginId,
// }) async {
//   dynamic transactionInitialisation;
//   try {
//     transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
//         businessShortCode: paybill == null ? "174379" : paybill,
//         transactionType: TransactionType.CustomerPayBillOnline,
//         amount: double.parse(amount),
//         partyA: phoneNumber,
//         partyB: paybill == null ? "174379" : paybill,
// //Lipa na Mpesa Online ShortCode
//         callBackURL: Uri(
//             scheme: "https",
//             host: "https://smartearn.co.ke/callback_url.php';",
//             path: "/1hhy6391"),
// //This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
//         accountReference: loginId,
//         phoneNumber: phoneNumber,
//         baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
//         transactionDesc: "Pay for Solar panel",
//         passKey:
//             "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
// //This passkey has been generated from Test Credentials from Safaricom Portal
//     print("TRANSACTION RESULT: " + transactionInitialisation.toString());
//     await FirebaseFirestore.instance
//         .collection('transactions')
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .collection(transactionInitialisation)
//         .add({});

//     return transactionInitialisation;
//   } catch (e) {
//     print("CAUGHT EXCEPTION: " + e.toString());
//   }
// }

import 'package:mpesa/mpesa.dart';

// Mpesa mpesa = Mpesa(
//   clientKey: "v6CvcZJ52GRS58ejAuTKZ5oychN76qex",
//   clientSecret: "QRAXCn9ekOGuKtM3",
//   passKey: "700c96b037e0e26e10e107c8144e6036239e12001614251fb3a63212064b71a7",
//   environment: "production",
// );
Mpesa mpesa = Mpesa(
  clientKey: "kWfU4U8AbQFt7mUMUpOlOq4syH3LASSA",
  clientSecret: "h2wYt6rPewxdBId5",
  passKey:
      "c918eb26bbeb80540c1054929978ad30bf2253d701361f1f6e30cd291e2cfce1".trim(),
  environment: "production",
);
