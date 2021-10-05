import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/widgets/done_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FeedbackComplaintScreen extends StatefulWidget {
  static const routeName = '/feedback-complaint';

  @override
  _FeedbackComplaintScreenState createState() =>
      _FeedbackComplaintScreenState();
}

class _FeedbackComplaintScreenState extends State<FeedbackComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  int optionIndex = 0;
  String _option;
  String whatsappId;
  String telegramId;
  String description;
  String name;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    List<String> options = [
      'Withdrawal issues',
      'Deposit issues',
      'Other issues',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback and Complaint'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              title('Feedback Form'),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'We would love to hear your thoughts, suggestions, concerns or problems with anything we can improve!',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              title('Feedback Type'),
              ...List.generate(
                  options.length,
                  (i) => GestureDetector(
                      onTap: () {
                        setState(() {
                          optionIndex = i;
                        });
                      },
                      child: option(options[i], i == optionIndex))),
              title('Describe your Feedback'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                constraints: BoxConstraints(minHeight: 120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200]),
                width: double.infinity,
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        'Please describe your problem or suggestion in detail, \nwe will follow up and solve as soon as possible',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please describe your problem ';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
              ),
              title('Attachment File'),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _getImage(),
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text('Add File'),
                            ],
                          ),
                        )),
                  ),
                  if (_image != null)
                    SizedBox(
                      width: 20,
                    ),
                  if (_image != null)
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
                    )
                ],
              ),
              title('Name'),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              title('WhatsApp Id'),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      whatsappId = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your whatsapp id';
                    }
                    return null;
                  },
                ),
              ),
              title('Telegram Id'),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      telegramId = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your telegram id';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 45,
                child: RaisedButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final imageData = await FirebaseStorage.instance
                          .ref('feedback/files/${user.userId}/')
                          .putFile(_image);

                      final url = await imageData.ref.getDownloadURL();
                      FirebaseFirestore.instance
                          .collection('admin')
                          .doc('feedback')
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .set({
                        'phone:': user.phoneNumber,
                        'whatsapp': whatsappId,
                        'telegram': telegramId,
                        'feedback': description,
                        'image': url,
                        'type': _option,
                        'status': false,
                        'date': DateTime.now().toIso8601String(),
                      });

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          // backgroundColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          content: DoneIcon(),
                        ),
                      );
                      Future.delayed(Duration(milliseconds: 2500))
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget option(String title, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          color: isSelected ? kPrimaryColor : Colors.grey[500],
        ),
        SizedBox(width: 10),
        Text(title),
      ]),
    );
  }

  Widget title(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No image selected')));
      }
    });
  }
}
