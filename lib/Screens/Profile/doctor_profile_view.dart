import 'package:doktorapp/Screens/Appointment/book_appointment.dart';
import 'package:doktorapp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileView extends StatefulWidget {
  static const id = 'DoctorProfileView';
  final doctorSpeciality;
  final doctorFullName;
  final doctorId;
  final doctorAvatar;
  final doctorContactNumber;
  final doctorAbout;
  DoctorProfileView(
      {@required this.doctorFullName,
      @required this.doctorSpeciality,
      @required this.doctorAbout,
        @required this.doctorAvatar,
      @required this.doctorId,
      @required this.doctorContactNumber});
  @override
  _DoctorProfileViewState createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  Color clockColor = kSecondaryColor;
  Color clockBackgroundColor = kBackgroundColor;
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
          child: Consumer<Globals>(builder: (context, globals, child) {
            return Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.doctorAvatar),
                        radius: kLargeCircleAvatarRadius,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        '${widget.doctorSpeciality}',
                        style: kNameTextStyle.copyWith(color: kSecondaryColor),
                      ),
                      Text(
                        'Dr. ${widget.doctorFullName}',
                        style: kBigHeadingTextStyle,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: kPageVerticalPadding * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: DoctorProfileViewActionButton(
                                icon: FontAwesomeIcons.phoneAlt,
                              ),
                              onTap: () {
                                launch("tel:${widget.doctorContactNumber}");
                              },
                            ),
                            GestureDetector(
                              child: DoctorProfileViewActionButton(
                                icon: Icons.messenger,
                              ),
                              onTap: () {
                                launch(
                                    'sms:${widget.doctorContactNumber}?body=Hi\nDr. ${widget.doctorFullName} contacting you via Doctor App for ');
                              },
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
                              '${widget.doctorAbout}',
                              style: kHintTextStyle.copyWith(
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: kPageVerticalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              onPressed: () //async
                  {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAppointment(doctorAvatar: widget.doctorAvatar,
                              doctorName: widget.doctorFullName,
                              doctorId: widget.doctorId,
                              doctorSpeciality: widget.doctorSpeciality,
                            )));
              },
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: kPageHorizontalPadding * 2,
                  vertical: (kPageVerticalPadding * 2) - 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRoundedCorners),
              ),
              child: Text(
                'Book Appointment',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
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
