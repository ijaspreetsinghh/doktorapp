import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';

class DoctorProfileView extends StatefulWidget {
  static const id = 'DoctorProfileView';
  @override
  _DoctorProfileViewState createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            child: Icon(
              Icons.more_vert_rounded,
            ),
            margin: EdgeInsets.only(right: kPageHorizontalPadding),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/defaultProfileImage.png'),
                      radius: kLargeCircleAvatarRadius,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Cardiologist',
                      style: kNameTextStyle.copyWith(color: kSecondaryColor),
                    ),
                    Text(
                      'Dr. Jaspreet Singh',
                      style: kBigHeadingTextStyle,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: kPageVerticalPadding * 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DoctorProfileViewActionButton(
                            icon: FontAwesomeIcons.phoneAlt,
                          ),
                          DoctorProfileViewActionButton(
                            icon: Icons.messenger,
                          ),
                          DoctorProfileViewActionButton(
                            icon: FontAwesomeIcons.video,
                          ),
                          DoctorProfileViewActionButton(
                            icon: FontAwesomeIcons.locationArrow,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'About',
                            style: kBigHeadingTextStyle,
                          ),
                          SizedBox(
                            height: kPageVerticalPadding - 5,
                          ),
                          Text(
                            'A grid list consists of a repeated pattern of cells arrayed in a vertical and horizontal layout. The GridView widget implements this component. Documentation.',
                            style: kHintTextStyle.copyWith(
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: kPageVerticalPadding * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Schedules',
                            style: kBigHeadingTextStyle,
                          ),
                          SizedBox(
                            height: kPageVerticalPadding * 2,
                          ),
                          DatePicker(
                            DateTime.now(), daysCount: 15,
                            // width: 60,
                            // height: 80,
                            controller: _controller,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: kPrimaryColor,
                            selectedTextColor: Colors.white,
                            dateTextStyle: TextStyle(fontSize: 18.0),
                            // dayTextStyle: kRichTextStyle1,
                            // monthTextStyle: kRichTextStyle1,
                            // inactiveDates: [
                            //   DateTime.now().add(Duration(days: 3)),
                            //   DateTime.now().add(Duration(days: 4)),
                            //   DateTime.now().add(Duration(days: 7))
                            // ],
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                _selectedValue = date;
                              });
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: kPageVerticalPadding * 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    color: kSecondaryColor,
                                  ),
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius:
                                        BorderRadius.circular(kRoundedCorners),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () //async
                                      {
                                    print(_selectedValue);
                                  },
                                  color: kPrimaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPageHorizontalPadding * 2,
                                      vertical: (kPageVerticalPadding * 2) - 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(kRoundedCorners),
                                  ),
                                  child: Text(
                                    'Appointment',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
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
}

class DoctorProfileViewActionButton extends StatelessWidget {
  final IconData icon;
  DoctorProfileViewActionButton({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding / 2),
      child: Icon(
        icon,
        color: kSecondaryColor,
      ),
      width: 55.0,
      height: 55.0,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(kRoundedCorners),
      ),
    );
  }
}
