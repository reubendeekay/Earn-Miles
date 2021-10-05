import 'package:earn_miles/bottom_nav.dart';
import 'package:earn_miles/constants.dart';
import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/homepage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String confirmPassword;
  String _password;
  String invitationCode;
  String phoneNumber;
  String _email;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;
  double opacity = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: Container(
                          height: size.height * 0.3,
                          width: size.width,
                          child: Lottie.asset('assets/login.json',
                              fit: BoxFit.cover)),
                    ),
                  )),
              ////////////////////////////////////////////////////////////////////////////////

              Positioned(
                  top: size.height * 0.04,
                  left: 20,
                  child: Text(
                    'Earn Miles',
                    style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  )),

              /////////////START OF AUTH FORM/////////////

              SingleChildScrollView(
                child: Column(
                  children: [
                    AnimatedContainer(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 1000),
                      height: size.height - MediaQuery.of(context).padding.top,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin ? 'Login' : 'Sign up',
                              style: GoogleFonts.roboto(
                                  fontSize: 36, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),

                            /////////////////////LOGIN FIELDS///////////////////////////
                            ///
                            ///
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300]),
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    if (val.length < 7) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: kPrimaryColor,
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      labelText: 'Email address',
                                      helperStyle:
                                          TextStyle(color: kPrimaryColor),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor, width: 1)),
                                      border: InputBorder.none),
                                  onChanged: (text) => {
                                        setState(() {
                                          _email = text;
                                        })
                                      }),
                            ),
                            if (!isLogin)
                              Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      if (val.length < 7) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: kPrimaryColor,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        labelText: 'Phone number',
                                        helperStyle:
                                            TextStyle(color: kPrimaryColor),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor,
                                                width: 1)),
                                        border: InputBorder.none),
                                    onChanged: (text) => {
                                          setState(() {
                                            phoneNumber = text;
                                          })
                                        }),
                              ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300]),
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (val.length < 6) {
                                      return 'Password should have atleast 6 characters';
                                    }

                                    return null;
                                  },
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: kPrimaryColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        child: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.remove_red_eye_outlined,
                                          size: 15,
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      labelText: 'Password',
                                      helperStyle:
                                          TextStyle(color: kPrimaryColor),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor, width: 1)),
                                      border: InputBorder.none),
                                  onChanged: (text) => {
                                        setState(() {
                                          _password = text;
                                        })
                                      }),
                            ),
                            if (!isLogin)
                              Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (val != _password) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    obscureText: !isConfirmPasswordVisible,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isConfirmPasswordVisible =
                                                  !isConfirmPasswordVisible;
                                            });
                                          },
                                          child: Icon(
                                            isConfirmPasswordVisible
                                                ? Icons.visibility_off_outlined
                                                : Icons.remove_red_eye_outlined,
                                            size: 15,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        labelText: 'Confirm password',
                                        helperStyle:
                                            TextStyle(color: kPrimaryColor),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor,
                                                width: 1)),
                                        border: InputBorder.none),
                                    onChanged: (text) => {
                                          setState(() {
                                            confirmPassword = text;
                                          })
                                        }),
                              ),
                            if (!isLogin)
                              AnimatedOpacity(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  opacity: isLogin ? 0 : 1,
                                  duration: Duration(milliseconds: 1000),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300]),
                                    child: TextFormField(
                                        validator: (val) {
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.card_giftcard_rounded,
                                              color: kPrimaryColor,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15),
                                            labelText: 'Invitation code',
                                            helperStyle:
                                                TextStyle(color: kPrimaryColor),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: kPrimaryColor,
                                                    width: 1)),
                                            border: InputBorder.none),
                                        onChanged: (text) => {
                                              setState(() {
                                                invitationCode = text;
                                              })
                                            }),
                                  )),
                            //////////////////////////////////////////////////////////////////////////////////////////////////
                            ///
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Forgot password'),
                                SizedBox(
                                  width: 30,
                                )
                              ],
                            ),

                            //////////////////////////////////////////////////////////////////////////////////////////////////
                            ///
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: kPrimaryColor,
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await trySubmit();
                                },
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        isLogin ? 'Sign in' : 'Sign up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(isLogin
                                    ? 'Dont have an account?'
                                    : 'Already have an account?'),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(
                                    isLogin ? 'Register' : 'Sign in',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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

      if (isLogin) {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(email: _email.trim(), password: _password.trim())
            .then((data) async {
          // Navigator.of(context).pushReplacementNamed(MyNav.routeName);
          await Provider.of<AuthProvider>(context, listen: false)
              .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
          ));
        });
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(
          email: _email.trim(),
          password: _password.trim(),
          phoneNumber: phoneNumber.trim(),
          invitation: invitationCode,
        )
            .then((_) async {
          // Navigator.of(context).pushReplacementNamed(MyNav.routeName);
          await Provider.of<AuthProvider>(context, listen: false)
              .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
          ));
        });
      }
    }
  }
}
