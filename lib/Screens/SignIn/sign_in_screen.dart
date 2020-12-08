import 'package:doktorapp/Screens/ForgotPassword/forgot_password.dart';
import 'package:doktorapp/Screens/SignUp/sign_up_screen.dart';
import 'package:doktorapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doktorapp/Screens/Profile/main_profile_page.dart';
import 'dart:ui';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInScreen extends StatefulWidget {
  static const id = 'SignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _saving = false;

  void _submit() {
    setState(() {
      _saving = true;
    });
  }

  final _signInFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  UserCredential loggedInUser;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  bool emailFieldOk = false;
  bool passwordFieldOk = false;
  bool _obscureText = true;
  bool showEmailBorder = false;
  bool showPasswordBorder = false;
  String email;
  String password;
  bool showAlert = false;
  void showAlertBox() {
    if (showAlert)
      AlertDialog(
        content: Text('Hello ji'),
      );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscureText == true
          ? showPasswordIcon = Icon(FontAwesomeIcons.eyeSlash)
          : showPasswordIcon = Icon(FontAwesomeIcons.eye);
    });
  }

  var showPasswordIcon = Icon(FontAwesomeIcons.eyeSlash);
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      dismissible: false,
      inAsyncCall: _saving,
      opacity: 0.7,
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: ListBody(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.login_outlined,
                            color: kPrimaryColor,
                          ),
                          Text(
                            ' Sign In',
                            style: kBigHeadingTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                showEmailBorder ? kBorderColor : Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(kRoundedCorners),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty ||
                                  !RegExp(emailRegex).hasMatch(value)) {
                                setState(() {
                                  showEmailBorder = true;
                                  emailFieldOk = false;
                                });
                              } else {
                                setState(() {
                                  emailFieldOk = true;
                                  showEmailBorder = false;
                                });
                              }
                              return null;
                            },
                            onSaved: (value) => email = value,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              // filled: true,
                              prefixIcon: Icon(FontAwesomeIcons.envelope),
                              labelText: 'Email',
                              labelStyle: kLabelTextStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kPageHorizontalPadding - 8,
                                  vertical: 15.0),
                              hintText: 'Enter your email',
                              hintStyle: kHintTextStyle,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: showPasswordBorder
                                ? kBorderColor
                                : Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(kRoundedCorners),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: _obscureText,
                            cursorColor: kPrimaryColor,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                setState(() {
                                  showPasswordBorder = true;
                                  passwordFieldOk = false;
                                });
                              } else {
                                setState(() {
                                  showPasswordBorder = false;
                                  passwordFieldOk = true;
                                });
                              }
                              return null;
                            },
                            onSaved: (value) => password = value,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              labelStyle: kLabelTextStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kPageHorizontalPadding - 8,
                                  vertical: 15.0),
                              isDense: true,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _toggle();
                                },
                                child: showPasswordIcon,
                              ),
                              hintText: 'Enter your password ',
                              hintStyle: kHintTextStyle,
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ForgotPassword.id);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15.0, 15.0, 0),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            'Forgot password?',
                            style: kRichTextStyle2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_signInFormKey.currentState.validate()) {
                            _signInFormKey.currentState.save();
                            if (emailFieldOk == true) {
                              if (passwordFieldOk == true) {
                                try {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  currentFocus.unfocus();

                                  _submit();
                                  final loggedInUser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  setState(() {
                                    _saving = false;
                                  });
                                  if (loggedInUser != null) {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        MainProfilePage.id, (route) => false);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'wrong-password') {
                                    setState(() {
                                      _saving = false;
                                    });
                                    Future<void> _showMyDialog() async {
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 2.0, sigmaY: 2.0),
                                            child: AlertDialog(
                                              shape: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kRoundedCorners),
                                              ),
                                              title: Text(
                                                'Invalid User Credential',
                                                style: kSubHeadingTextStyle
                                                    .copyWith(fontSize: 16.0),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                      'Something is not right. Try checking your email or password.',
                                                      style: kRichTextStyle1,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: kRichTextStyle2,
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    _showMyDialog();
                                  } else if (e.code == 'user-not-found') {
                                    setState(() {
                                      _saving = false;
                                    });
                                    Future<void> _showMyDialog() async {
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 2.0, sigmaY: 2.0),
                                            child: AlertDialog(
                                              shape: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kRoundedCorners),
                                              ),
                                              title: Text(
                                                'User Not Found',
                                                style: kSubHeadingTextStyle
                                                    .copyWith(fontSize: 16.0),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                      'Something is not right. Try checking your email or password. $email doesn\'t exists',
                                                      style: kRichTextStyle1,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: kRichTextStyle2,
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    _showMyDialog();
                                  }
                                }
                              }
                            }
                          }
                        },
                        color: kPrimaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: kPageHorizontalPadding * 1,
                            vertical: kPageVerticalPadding * 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kRoundedCorners),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showEmailBorder = showPasswordBorder = false;
                            });
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: kRichTextStyle1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign Up',
                                    style: kRichTextStyle2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
