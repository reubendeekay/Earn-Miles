import 'package:earn_miles/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Your Email',
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
              ),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: RaisedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email.trim());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reset link sent to $email'),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: kPrimaryColor,
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Send Reset Link',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
