import 'package:doktorapp/Screens/Profile/update_profile_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  void initState() {
    Globals.getUserData();
    super.initState();
  }

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: kPageVerticalPadding),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/userImage.jpg'),
                          radius: kLargeCircleAvatarRadius,
                        ),
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Full Name',
                        myEntryData: Globals.userFullName ?? 'Add Name',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Email',
                        myEntryData: Globals.userEmail ?? 'Add Email',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Gender',
                        myEntryData: Globals.userGender ?? 'Add Gender',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Date of Birth',
                        myEntryData: Globals.userDOB ?? 'Add Date of Birth',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Blood Group',
                        myEntryData:
                            Globals.userBloodGroup ?? 'Add Blood Group',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Marital Status',
                        myEntryData:
                            Globals.userFirstName ?? 'Add Marital Status',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Height',
                        myEntryData: Globals.userHeight ?? 'Add Height',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Weight in Kgs',
                        myEntryData: Globals.userFirstName ?? 'Add Weight',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Emergency Contact Number',
                        myEntryData: Globals.userFirstName ??
                            'Add Emergency Contact Number',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Address',
                        myEntryData: Globals.userFirstName ?? 'Add Address',
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserProfileDataBuilder(
                        myEntryTitle: 'Allergies',
                        myEntryData: Globals.userAllergies ?? 'Add Allergies',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Current Medication',
                        myEntryData: Globals.userCurrentMedication ??
                            'Add Current Medication',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Past Medication',
                        myEntryData:
                            Globals.userPastMedication ?? 'Add Past Medication',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Chronic Diseases',
                        myEntryData:
                            Globals.chronicDiseases ?? 'Add Chronic Diseases',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Injuries',
                        myEntryData: Globals.userInjuries ?? 'Add Injuries',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Surgeries',
                        myEntryData: Globals.userSurgeries ?? 'Add Surgeries',
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserProfileDataBuilder(
                        myEntryTitle: 'Smoking Habits',
                        myEntryData: Globals.userSmokingHabit ?? 'Add Details',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Alcohol Consumption',
                        myEntryData:
                            Globals.userAlcoholConsumption ?? 'Add Details',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Activity Level',
                        myEntryData: Globals.userActivityLevel ?? 'Add Details',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Food Preference',
                        myEntryData:
                            Globals.userFoodPreference ?? 'Add Details',
                      ),
                      UserProfileDataBuilder(
                        myEntryTitle: 'Occupation',
                        myEntryData: Globals.userOccupation ?? 'Add Details',
                      ),
                    ],
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
