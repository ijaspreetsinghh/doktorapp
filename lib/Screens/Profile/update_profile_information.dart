import 'package:flutter/material.dart';
import 'package:doktorapp/globals.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdateProfileInformation extends StatefulWidget {
  static const id = 'UpdateProfileInformation';
  @override
  _UpdateProfileInformationState createState() =>
      _UpdateProfileInformationState();
}

class _UpdateProfileInformationState extends State<UpdateProfileInformation> {
  bool showFirstNameBorder = false;
  bool firstNameFieldOk = false;
  bool genderFieldOk = false;
  bool genderBorder = false;
  TextEditingController firstNameController =
      TextEditingController(text: 'Not Set');
  TextEditingController genderController =
      TextEditingController(text: 'Not Set');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Information',
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: IconThemeData(color: kPrimaryColor),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kPageHorizontalPadding),
            child: Icon(Icons.save),
          )
        ],
        backgroundColor: kWhiteBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            SizedBox(
              height: kPageVerticalPadding * 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:
                            showFirstNameBorder ? kBorderColor : Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(kRoundedCorners),
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
                        controller: firstNameController,
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(FontAwesomeIcons.signature),
                          labelText: 'Full Name',
                          labelStyle: kLabelTextStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        color:
                            showFirstNameBorder ? kBorderColor : Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(kRoundedCorners),
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
                              genderBorder = true;
                              genderFieldOk = false;
                            });
                          } else {
                            setState(() {
                              genderBorder = false;
                              genderFieldOk = true;
                            });
                          }
                          return null;
                        },
                        controller: genderController,
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(FontAwesomeIcons.signature),
                          labelText: 'Full Name',
                          labelStyle: kLabelTextStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
