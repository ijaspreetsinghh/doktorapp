import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPassword extends StatefulWidget {
  static const id = 'ForgotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _saving = false;

  void _submit() {
    setState(() {
      _saving = true;
    });
  }

  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  bool showEmailBorder = false;
  String email;
  String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  bool emailFieldOk = false;

  final _forgotPasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      dismissible: false,
      inAsyncCall: _saving,
      opacity: 0.7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                child: Form(
                  key: _forgotPasswordKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot your password? \nDon\'t Worry.',
                        style: kBigHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Enter your registered email to get password reset link.',
                                    style: kSubHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: showEmailBorder
                                      ? kBorderColor
                                      : Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
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
                                      borderRadius: BorderRadius.circular(
                                          kRoundedCorners),
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
                            RaisedButton(
                              onPressed: () async {
                                email = emailController.text.toLowerCase();
                                if (_forgotPasswordKey.currentState
                                    .validate()) {
                                  _forgotPasswordKey.currentState.save();
                                  if (emailFieldOk) {
                                    try {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      currentFocus.unfocus();

                                      _submit();
                                      await _auth.sendPasswordResetEmail(
                                          email: email);
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
                                                  'Email sent',
                                                  style: kSubHeadingTextStyle
                                                      .copyWith(fontSize: 16.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                        'You will receive an email to reset your password shortly.',
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
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                                context,
                                                                SignInScreen.id,
                                                                (route) =>
                                                                    false);
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
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
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
                                                    'Can\'t send email',
                                                    style: kSubHeadingTextStyle
                                                        .copyWith(
                                                            fontSize: 16.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                          'No user registered with that email, please check your email and try again.',
                                                          style:
                                                              kRichTextStyle1,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'OK',
                                                          style:
                                                              kRichTextStyle2,
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
                              },
                              color: kPrimaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: kPageHorizontalPadding * 1,
                                  vertical: kPageVerticalPadding * 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ])
                    ],
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
