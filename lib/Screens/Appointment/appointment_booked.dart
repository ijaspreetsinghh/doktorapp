import 'package:doktorapp/Screens/Profile/main_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentBooked extends StatefulWidget {
  static const id = 'AppointmentBooked';
  @override
  _AppointmentBookedState createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackgroundColor,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Appointment Booked',
                style: kBigHeadingTextStyle,
              ),
              SizedBox(
                height: 50.0,
              ),
              Icon(
                FontAwesomeIcons.solidCheckCircle,
                size: 50.0,
                color: Colors.green,
              ),
              SizedBox(
                height: 100.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainProfilePage.id, (route) => false);
                    },
                    color: kPrimaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: kPageHorizontalPadding * 2,
                        vertical: (kPageVerticalPadding * 2) - 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRoundedCorners),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
