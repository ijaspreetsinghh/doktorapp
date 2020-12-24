import 'package:doktorapp/Screens/Profile/update_profile_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class UserProfileInfo extends StatefulWidget {
  static const id = 'UserProfileInfo';

  @override
  _UserProfileInfoState createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return TabsUserInfo();
  }
}

class TabsUserInfo extends StatefulWidget {
  @override
  _TabsUserInfoState createState() => _TabsUserInfoState();
}

class _TabsUserInfoState extends State<TabsUserInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfileInformation(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.only(right: kPageHorizontalPadding),
                child: Icon(
                  FontAwesomeIcons.edit,
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'My Information',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: kWhiteBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            indicatorColor: kPrimaryColor,
            labelColor: Colors.black,
            labelStyle: kRichTextStyle2,
            indicatorWeight: 3.0,
            tabs: [
              Tab(
                child: Text('Personal'),
              ),
              Tab(
                child: Text('Medical'),
              ),
              Tab(
                child: Text('Lifestyle'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPageHorizontalPadding,
                      vertical: kPageVerticalPadding),
                  child: Consumer<Globals>(
                    builder: (context, globals, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: kPageVerticalPadding),
                            child: GestureDetector(
                              onTap: () {
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
                                          scrollable: false,
                                          shape: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                                kRoundedCorners),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FlatButton(
                                                    onPressed: () {
                                                      print('1');
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons
                                                            .photo_size_select_actual_outlined),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Text(
                                                          'View Profile Photo',
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    )),
                                                FlatButton(
                                                    onPressed: () {
                                                      print('2');
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.add_a_photo),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Text(
                                                          'Change Profile Photo',
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }

                                _showMyDialog();
                              },
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.edit_outlined,
                                ),
                                backgroundImage: AssetImage(
                                    'assets/images/defaultProfileImage.png'),
                                radius: kLargeCircleAvatarRadius,
                              ),
                            ),
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Full Name',
                            myEntryData: globals.userFullName ?? 'Add Name',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Email',
                            myEntryData: globals.userEmail ?? 'Add Email',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Gender',
                            myEntryData: globals.userGender ?? 'Add Gender',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Date of Birth',
                            myEntryData: globals.userDOB ?? 'Add Date of Birth',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Blood Group',
                            myEntryData:
                                globals.userBloodGroup ?? 'Add Blood Group',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Marital Status',
                            myEntryData: globals.userMaritalStatus ??
                                'Add Marital Status',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Height',
                            myEntryData: globals.userHeight ?? 'Add Height',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Weight in Kgs',
                            myEntryData: globals.userWeight ?? 'Add Weight',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Emergency Contact Number',
                            myEntryData: globals.userEmergencyContactNumber ??
                                'Add Emergency Contact Number',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Address',
                            myEntryData: globals.userAddress ?? 'Add Address',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPageHorizontalPadding,
                      vertical: kPageVerticalPadding),
                  child: Consumer<Globals>(
                    builder: (context, globals, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserProfileDataBuilder(
                            myEntryTitle: 'Allergies',
                            myEntryData:
                                globals.userAllergies ?? 'Add Allergies',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Current Medication',
                            myEntryData: globals.userCurrentMedication ??
                                'Add Current Medication',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Past Medication',
                            myEntryData: globals.userPastMedication ??
                                'Add Past Medication',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Chronic Diseases',
                            myEntryData: globals.chronicDiseases ??
                                'Add Chronic Diseases',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Injuries',
                            myEntryData: globals.userInjuries ?? 'Add Injuries',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Surgeries',
                            myEntryData:
                                globals.userSurgeries ?? 'Add Surgeries',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPageHorizontalPadding,
                      vertical: kPageVerticalPadding),
                  child: Consumer<Globals>(
                    builder: (context, globals, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserProfileDataBuilder(
                            myEntryTitle: 'Smoking Habits',
                            myEntryData:
                                globals.userSmokingHabit ?? 'Add Details',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Alcohol Consumption',
                            myEntryData:
                                globals.userAlcoholConsumption ?? 'Add Details',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Activity Level',
                            myEntryData:
                                globals.userActivityLevel ?? 'Add Details',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Food Preference',
                            myEntryData:
                                globals.userFoodPreference ?? 'Add Details',
                          ),
                          UserProfileDataBuilder(
                            myEntryTitle: 'Occupation',
                            myEntryData:
                                globals.userOccupation ?? 'Add Details',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileDataBuilder extends StatelessWidget {
  UserProfileDataBuilder(
      {@required this.myEntryTitle, @required this.myEntryData});
  final String myEntryTitle;
  final String myEntryData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPageVerticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(myEntryTitle,
              style: kRichTextStyle1.copyWith(
                // fontSize: 16.0,
                color: kSecondaryColor,
              )),
          Flexible(child: Container()),
          Expanded(
            flex: 3,
            child: Text(
              myEntryData,
              textAlign: TextAlign.end,
              style: kRichTextStyle1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
