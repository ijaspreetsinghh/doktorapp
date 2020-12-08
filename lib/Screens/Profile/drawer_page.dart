import 'package:doktorapp/Screens/Consultation/consultation.dart';
import 'package:doktorapp/Screens/MedicalRecord/medical_record.dart';
import 'package:doktorapp/Screens/MyDoctor/my_doctor.dart';
import 'package:doktorapp/Screens/Orders/orders.dart';
import 'package:doktorapp/Screens/Reminder/reminder.dart';
import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:doktorapp/Screens/TestBooking/test_booking.dart';
import 'package:doktorapp/Screens/UserProfileInfo/user_profile_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/Screens/Appointment/active_appointment.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktorapp/globals.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String currentUserId;
String userFirstName;
String userLastName;

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.

        children: <Widget>[
          Container(
            height: 100.0,
            margin: EdgeInsets.only(bottom: 20.0),
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              duration: Duration(seconds: 3),
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15.0,
                  ),
                  CircleAvatar(
                    backgroundColor: kWhiteBackgroundColor,
                    foregroundColor: kWhiteBackgroundColor,
                    backgroundImage: AssetImage(
                      'assets/images/defaultProfileImage.png',
                    ),
                    radius: kMediumCircleAvatarRadius,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, UserProfileInfo.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${Globals.userFullName} ',
                                overflow: TextOverflow.ellipsis,
                                style: kNameTextStyle,
                              ),
                              Text(
                                'View and edit profile',
                                style: kAccentTextStyle,
                              )
                            ],
                          ),
                          height: 60.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: kWhiteBackgroundColor,
              ),
            ),
          ),
          DrawerListItem(
            itemTitle: 'Appointments',
            itemLeadingIcon: Icon(
              Icons.calendar_today_outlined,
              color: kPrimaryColor,
            ),
            navigationPageId: ActiveAppointment.id,
            itemTrailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
          ),
          DrawerListItem(
            itemTitle: 'Test Booking',
            itemLeadingIcon: Icon(
              Icons.medical_services_outlined,
              color: kPrimaryColor,
            ),
            navigationPageId: TestBooking.id,
            itemTrailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
          ),
          DrawerListItem(
            itemTitle: 'Orders',
            itemLeadingIcon: Icon(
              Icons.add_shopping_cart_rounded,
              color: kPrimaryColor,
            ),
            navigationPageId: Orders.id,
            itemTrailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
          ),
          DrawerListItem(
            itemTitle: 'Consultation',
            itemLeadingIcon: Icon(
              Icons.chat_bubble_outline,
              color: kPrimaryColor,
            ),
            navigationPageId: Consultation.id,
            itemTrailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
          ),
          Visibility(
            visible: Globals.userType == 'Doctor' ? false : true,
            child: DrawerListItem(
              itemTitle: 'My Doctors',
              itemLeadingIcon: Icon(
                Icons.person_outline_outlined,
                color: kPrimaryColor,
              ),
              navigationPageId: MyDoctor.id,
              itemTrailingIcon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: kDrawerListItemTrailingIconSize,
              ),
            ),
          ),
          Visibility(
            visible: Globals.userType == 'Doctor' ? false : true,
            child: DrawerListItem(
              itemTitle: 'Medical Records',
              itemLeadingIcon: Icon(
                Icons.file_copy_outlined,
                color: kPrimaryColor,
              ),
              navigationPageId: MedicalRecord.id,
              itemTrailingIcon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: kDrawerListItemTrailingIconSize,
              ),
            ),
          ),
          DrawerListItem(
            itemTitle: 'Reminders',
            itemLeadingIcon: Icon(
              Icons.alarm,
              color: kPrimaryColor,
            ),
            navigationPageId: Reminder.id,
            itemTrailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
          ),
          Divider(
            thickness: 20.0,
            color: kBackgroundColor,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: kMenuItemTextStyle,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: kDrawerListItemTrailingIconSize,
            ),
            onTap: () {
              print('settings pressed');
            },
          ),
          Divider(
            thickness: 20.0,
            color: kBackgroundColor,
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text(
              'Sign Out',
              style: kMenuItemTextStyle,
            ),
            trailing: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.transparent,
            ),
            onTap: () {
              Globals.auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.id, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final Icon itemLeadingIcon;
  final String itemTitle;
  final Icon itemTrailingIcon;
  final String navigationPageId;
  DrawerListItem(
      {@required this.itemTitle,
      @required this.itemLeadingIcon,
      @required this.itemTrailingIcon,
      @required this.navigationPageId});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: itemLeadingIcon,
      title: Text(
        itemTitle,
        style: kMenuItemTextStyle,
      ),
      trailing: itemTrailingIcon,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, navigationPageId);
      },
    );
  }
}
