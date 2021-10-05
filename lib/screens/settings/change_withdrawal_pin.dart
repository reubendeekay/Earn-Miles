import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/widgets/done_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeWithdrawalPinScreen extends StatefulWidget {
  static const routeName = '/change-withdrawal-pin';

  @override
  _ChangeWithdrawalPinScreenState createState() =>
      _ChangeWithdrawalPinScreenState();
}

class _ChangeWithdrawalPinScreenState extends State<ChangeWithdrawalPinScreen> {
  final _formKey = GlobalKey<FormState>();
  String initialPin;
  String newPin;
  String confirmPin;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Withdrawal Pin'),
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
                child: Text('Original Pin'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your original pin';
                    }
                    if (val != user.withdrawalPin) {
                      return 'Incorrect current pin';
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
                    hintText: 'Enter original pin',
                  ),
                  onChanged: (val) {
                    setState(() {
                      initialPin = val;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('New Pin'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your new pin';
                    }
                    if (val.length < 4) {
                      return 'Pin must be at least 4 characters';
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
                    hintText: 'Enter the new pin',
                  ),
                  onChanged: (val) {
                    setState(() {
                      newPin = val;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('Confirm Pin'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please confirm your new pin';
                    }
                    if (val != newPin) {
                      return 'Pins do not match';
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
                    hintText: 'Confirm new pin',
                  ),
                  onChanged: (val) {
                    setState(() {
                      confirmPin = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
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
}
