import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/widgets/done_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String initialPassword;
  String newPassword;
  String confirmPassword;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Login Password'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('Original Password'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your initial password';
                    }
                    if (val != user.password) {
                      return 'Incorrect initial password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey[500],
                          width: 1,
                        )),
                    hintText: 'Enter original password',
                  ),
                  onChanged: (val) {
                    setState(() {
                      initialPassword = val;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('New Password'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please confirm the password';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey[500],
                          width: 1,
                        )),
                    hintText: 'Enter the new password',
                  ),
                  onChanged: (val) {
                    setState(() {
                      newPassword = val;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('Confirm Password'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please confirm the password';
                    }
                    if (val != newPassword) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey[500],
                          width: 1,
                        )),
                    hintText: 'Confirm new password',
                  ),
                  onChanged: (val) {
                    setState(() {
                      confirmPassword = val;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Forgot original password',
                  style: TextStyle(
                      color: Colors.red[900],
                      decoration: TextDecoration.underline),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () async {
                    await trySubmit();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        content: DoneIcon(),
                      ),
                    );
                    Future.delayed(Duration(milliseconds: 2500))
                        .then((value) => Navigator.pop(context));
                  },
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> trySubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await FirebaseAuth.instance.currentUser.updatePassword(newPassword);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'password': newPassword});
      await FirebaseAuth.instance.currentUser.updatePassword(newPassword);
    }
  }
}
