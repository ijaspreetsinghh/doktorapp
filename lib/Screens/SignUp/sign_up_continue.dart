import 'package:doktorapp/Screens/Profile/main_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpContinue extends StatefulWidget {
  static const id = 'SignUpContinue';

  @override
  _SignUpContinueState createState() => _SignUpContinueState();
}

class _SignUpContinueState extends State<SignUpContinue> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String currentUserId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        currentUserId = loggedInUser.uid;
        print(currentUserId);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUserId)
        .set({
          'firstName': firstName, // John Doe
          'lastName': lastName, // Stokes and Sons
          'userId': currentUserId,
          'userType': 'Citizen',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  UserCredential newUser;

  final _signUpFormKey = GlobalKey<FormState>();
  bool _saving = false;

  void _submit() {
    setState(() {
      _saving = true;
    });
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool showFirstNameBorder = false;
  bool showLastNameBorder = false;
  bool firstNameFieldOk = false;
  bool lastNameFieldOk = false;

  String firstName;
  String lastName;

  var showPasswordIcon = Icon(FontAwesomeIcons.eyeSlash);
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
                  height: 75.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Just one step more',
                          style: kBigHeadingTextStyle,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          'Some information about you.',
                          style: kSubHeadingTextStyle,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: showFirstNameBorder
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
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 3 ||
                                    value.length > 15) {
                                  setState(() {
                                    showFirstNameBorder = true;
                                    firstNameFieldOk = false;
                                  });
                                } else {
                                  setState(() {
                                    showFirstNameBorder = false;
                                    firstNameFieldOk = true;
                                  });
                                }
                                return null;
                              },
                              onSaved: (value) => firstName = value,
                              controller: firstNameController,
                              cursorColor: kPrimaryColor,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(FontAwesomeIcons.signature),
                                labelText: 'First Name',
                                labelStyle: kLabelTextStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: kPageHorizontalPadding - 8,
                                    vertical: 15.0),
                                hintText: 'Enter your first name',
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
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: showLastNameBorder
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
                              controller: lastNameController,
                              cursorColor: kPrimaryColor,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 3 ||
                                    value.length > 20) {
                                  setState(() {
                                    showLastNameBorder = true;
                                    lastNameFieldOk = false;
                                  });
                                } else {
                                  setState(() {
                                    showLastNameBorder = false;
                                    lastNameFieldOk = true;
                                  });
                                }
                                return null;
                              },
                              onSaved: (value) => lastName = value,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(FontAwesomeIcons.signature),
                                labelText: 'Last Name',
                                labelStyle: kLabelTextStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: kPageHorizontalPadding - 8,
                                    vertical: 15.0),
                                hintText: 'Enter your last name',
                                hintStyle: kHintTextStyle,
                                isDense: true,
                                isCollapsed: true,
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
                        RaisedButton(
                          onPressed: () async {
                            firstName = firstNameController.text;
                            lastName = lastNameController.text;
                            if (_signUpFormKey.currentState.validate()) {
                              _signUpFormKey.currentState.save();

                              if (firstNameFieldOk) {
                                if (lastNameFieldOk) {
                                  try {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    currentFocus.unfocus();
                                    _submit();
                                    await addUser();
                                    setState(() {
                                      _saving = false;
                                    });
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        MainProfilePage.id, (route) => false);
                                  } catch (e) {
                                    print(e);
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
