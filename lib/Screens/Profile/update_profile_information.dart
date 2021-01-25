import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:doktorapp/globals.dart';

class UpdateProfileInformation extends StatefulWidget {
  static const id = 'UpdateProfileInformation';
  @override
  _UpdateProfileInformationState createState() =>
      _UpdateProfileInformationState();
}

class _UpdateProfileInformationState extends State<UpdateProfileInformation> {
  bool showFirstNameBorder = false;
  bool showLastNameBorder = false;
  bool firstNameFieldOk = false;
  bool lastNameFieldOk = false;
  bool lastNameBorder = false;
  final _updateInformationFormKey = GlobalKey<FormState>();

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
            child: GestureDetector(
                onTap: () {
                  if (_updateInformationFormKey.currentState.validate()) {
                    // _updateInformationFormKey.currentState.save();
                  }
                },
                child: Icon(Icons.save)),
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
                padding:
                    EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                child: Consumer<Globals>(
                  builder: (context, globals, child) {
                    TextEditingController firstNameController =
                        TextEditingController(text: globals.userFirstName);
                    TextEditingController lastNameController =
                        TextEditingController(text: globals.userLastName);

                    return Form(
                      key: _updateInformationFormKey,
                      child: Column(
                        children: [
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 3 ||
                                      value.length > 15) {
                                    setState(() {
                                      lastNameBorder = true;
                                      lastNameFieldOk = false;
                                    });
                                  } else {
                                    setState(() {
                                      lastNameBorder = false;
                                      lastNameFieldOk = true;
                                    });
                                  }
                                  return null;
                                },
                                controller: lastNameController,
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.name,
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
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
