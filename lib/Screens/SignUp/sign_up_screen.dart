import 'package:doktorapp/Screens/Profile/main_profile_page.dart';
import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  static const id = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  String currentUserId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

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

  String userType;
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUserId)
        .set({
          'firstName': firstName, // John Doe
          'lastName': lastName, 'userType': userType,
          // Stokes and Sons
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addDoctor() {
    // Call the user's CollectionReference to add a new user
    return doctors
        .doc(currentUserId)
        .set({
          'firstName': firstName, // John Doe
          'lastName': lastName, // Stokes and Sons
          'userId': currentUserId,
          'speciality': speciality,
          'doctorAbout': aboutDoctor,
          'userType': userType,
          'doctorContactNumber': doctorContactNumber,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  UserCredential newUser;

  bool _saving = false;

  void _submit() {
    setState(() {
      _saving = true;
    });
  }

  String email;
  String password;
  String speciality = 'default speciality';
  String doctorContactNumber = '9999999999';
  String aboutDoctor = 'default doctor about';
  final _signUpFormKey = GlobalKey<FormState>();
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController doctorSpecialityController = TextEditingController();
  TextEditingController doctorContactNumberController = TextEditingController();
  TextEditingController doctorAboutController = TextEditingController();
  bool _obscureText = true;
  bool showEmailBorder = false;
  bool showPasswordBorder = false;
  bool showConfirmPasswordBorder = false;
  bool showDoctorSpecialityBorder = false;
  bool doctorSpecialityFieldOk = false;
  bool emailFieldOk = false;
  bool firstNameFieldOk = false;
  bool passwordFieldOk = false;
  bool confirmPasswordFieldOk = false;
  bool showDoctorContactNumberBorder = false;
  bool doctorContactNumberFieldOk = false;
  bool doctorAboutFieldOk = false;

  bool showDoctorAboutBorder = false;
  String firstName;

  String lastName;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscureText == true
          ? showPasswordIcon = Icon(FontAwesomeIcons.eyeSlash)
          : showPasswordIcon = Icon(FontAwesomeIcons.eye);
    });
  }

  String selectedUserType = 'Citizen';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool showFirstNameBorder = false;
  bool showLastNameBorder = false;
  bool lastNameFieldOk = false;
  Key userTypeChooser;
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
                    key: _signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.user,
                              color: kPrimaryColor,
                            ),
                            Text(
                              ' New Registration',
                              style: kBigHeadingTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Center(
                          child: Text(
                            "I am a",
                            style: kSubHeadingTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  'Citizen',
                                  style: TextStyle(
                                      color: selectedUserType == 'Citizen'
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 16.0,
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                key: userTypeChooser,
                                padding: EdgeInsets.symmetric(
                                    horizontal: kPageHorizontalPadding * 2,
                                    vertical: kPageVerticalPadding),
                                decoration: BoxDecoration(
                                  color: selectedUserType == 'Citizen'
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(kRoundedCorners),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedUserType = 'Citizen';
                                });
                              },
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  'Doctor',
                                  style: TextStyle(
                                      color: selectedUserType == 'Doctor'
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 16.0,
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                key: userTypeChooser,
                                padding: EdgeInsets.symmetric(
                                    horizontal: kPageHorizontalPadding * 2,
                                    vertical: kPageVerticalPadding),
                                decoration: BoxDecoration(
                                  color: selectedUserType == 'Doctor'
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(kRoundedCorners),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedUserType = 'Doctor';
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AnimatedContainer(
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
                                    textCapitalization:
                                        TextCapitalization.sentences,
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
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.signature),
                                      labelText: 'First Name',
                                      labelStyle: kLabelTextStyle,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              kPageHorizontalPadding - 8,
                                          vertical: 15.0),
                                      hintText: 'Enter your first name',
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
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Flexible(
                              child: AnimatedContainer(
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
                                    textCapitalization:
                                        TextCapitalization.sentences,
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
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.signature),
                                      labelText: 'Last Name',
                                      labelStyle: kLabelTextStyle,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              kPageHorizontalPadding - 8,
                                          vertical: 15.0),
                                      hintText: 'Enter your last name',
                                      hintStyle: kHintTextStyle,
                                      isDense: true,
                                      isCollapsed: true,
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  showEmailBorder ? kBorderColor : Colors.white,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.circular(kRoundedCorners),
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(emailRegex).hasMatch(value) ||
                                    value.length > 50) {
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
                              controller: emailController,
                              cursorColor: kPrimaryColor,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
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
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: showPasswordBorder
                                  ? kBorderColor
                                  : Colors.white,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.circular(kRoundedCorners),
                          ),
                          child: Container(
                            // color: Colors.white,
                            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(kRoundedCorners),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: kPrimaryColor,
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 6 ||
                                    value.length > 30) {
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
                                isCollapsed: true,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggle();
                                  },
                                  child: showPasswordIcon,
                                ),
                                hintText: '6-30 character password',
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: selectedUserType == 'Doctor' ? true : false,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: showDoctorContactNumberBorder
                                    ? kBorderColor
                                    : Colors.white,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.circular(kRoundedCorners),
                            ),
                            child: Container(
                              // color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: TextFormField(
                                controller: doctorContactNumberController,
                                keyboardType: TextInputType.number,
                                cursorColor: kPrimaryColor,
                                validator: (value) {
                                  if (value.length != 10) {
                                    setState(() {
                                      showDoctorContactNumberBorder = true;
                                      doctorContactNumberFieldOk = false;
                                    });
                                  } else {
                                    setState(() {
                                      showDoctorContactNumberBorder = false;
                                      doctorContactNumberFieldOk = true;
                                    });
                                  }
                                  return null;
                                },
                                onSaved: (value) => doctorContactNumber = value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Your Contact Number',
                                  labelStyle: kLabelTextStyle,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: kPageHorizontalPadding - 8,
                                      vertical: 15.0),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: '10 digit contact number',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon: Icon(Icons.phone),
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: selectedUserType == 'Doctor' ? true : false,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: showDoctorSpecialityBorder
                                    ? kBorderColor
                                    : Colors.white,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.circular(kRoundedCorners),
                            ),
                            child: Container(
                              // color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: TextFormField(
                                controller: doctorSpecialityController,
                                keyboardType: TextInputType.text,
                                cursorColor: kPrimaryColor,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 2 ||
                                      value.length > 30) {
                                    setState(() {
                                      showDoctorSpecialityBorder = true;
                                      doctorSpecialityFieldOk = false;
                                    });
                                  } else {
                                    setState(() {
                                      showDoctorSpecialityBorder = false;
                                      doctorSpecialityFieldOk = true;
                                    });
                                  }
                                  return null;
                                },
                                onSaved: (value) => speciality = value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Your Speciality',
                                  labelStyle: kLabelTextStyle,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: kPageHorizontalPadding - 8,
                                      vertical: 15.0),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: 'General or Cardiologist etc.',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon:
                                      Icon(Icons.admin_panel_settings_outlined),
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: selectedUserType == 'Doctor' ? true : false,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: showDoctorSpecialityBorder
                                    ? kBorderColor
                                    : Colors.white,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.circular(kRoundedCorners),
                            ),
                            child: Container(
                              // color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: TextFormField(
                                controller: doctorAboutController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                cursorColor: kPrimaryColor,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 5 ||
                                      value.length > 250) {
                                    setState(() {
                                      showDoctorAboutBorder = true;
                                      doctorAboutFieldOk = false;
                                    });
                                  } else {
                                    setState(() {
                                      showDoctorAboutBorder = false;
                                      doctorAboutFieldOk = true;
                                    });
                                  }
                                  return null;
                                },
                                onSaved: (value) => aboutDoctor = value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'About you',
                                  labelStyle: kLabelTextStyle,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: kPageHorizontalPadding - 8,
                                      vertical: 15.0),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: '250 characters maximum.',
                                  hintStyle: kHintTextStyle,
                                  prefixIcon:
                                      Icon(Icons.admin_panel_settings_outlined),
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            email = emailController.text.toLowerCase();
                            password = passwordController.text;

                            if (_signUpFormKey.currentState.validate()) {
                              _signUpFormKey.currentState.save();

                              if (firstNameFieldOk) {
                                if (lastNameFieldOk) {
                                  if (emailFieldOk) {
                                    if (passwordFieldOk) {
                                      if (doctorSpecialityFieldOk ||
                                          selectedUserType == 'Citizen') {
                                        if (doctorContactNumberFieldOk ||
                                            selectedUserType == 'Citizen') {
                                          userType = selectedUserType;

                                          try {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);

                                            currentFocus.unfocus();
                                            _submit();
                                            final newUser = await _auth
                                                .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                            getCurrentUser();
                                            if (selectedUserType == 'Citizen') {
                                              addUser();
                                            } else {
                                              addDoctor();
                                            }
                                            setState(() {
                                              _saving = false;
                                            });
                                            if (newUser != null) {
                                              Navigator.pushNamed(
                                                  context, MainProfilePage.id);
                                            }
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code ==
                                                'email-already-in-use') {
                                              setState(() {
                                                _saving = false;
                                              });
                                              Future<void>
                                                  _showMyDialog() async {
                                                return showDialog<void>(
                                                  context: context,
                                                  barrierDismissible:
                                                      true, // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 2.0,
                                                          sigmaY: 2.0),
                                                      child: AlertDialog(
                                                        shape:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  kRoundedCorners),
                                                        ),
                                                        title: Text(
                                                          'Can\'t Sign-Up You',
                                                          style:
                                                              kSubHeadingTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16.0),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text(
                                                                'Email already registered, try signing-in. You can reset your password anytime if you don\'t remember.',
                                                                style:
                                                                    kRichTextStyle1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                              onPressed: () {
                                                                Navigator.pushNamedAndRemoveUntil(
                                                                    context,
                                                                    SignInScreen
                                                                        .id,
                                                                    (route) =>
                                                                        false);
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
                                          } catch (e) {
                                            print(e);
                                          }
                                        }
                                      }
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
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop((context));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
                                  style: kRichTextStyle1,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Sign In',
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
