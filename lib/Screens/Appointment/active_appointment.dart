import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doktorapp/components.dart';
import 'package:provider/provider.dart';

class ActiveAppointment extends StatefulWidget {
  static const id = 'ActiveAppointment';
  @override
  _ActiveAppointmentState createState() => _ActiveAppointmentState();
}

class _ActiveAppointmentState extends State<ActiveAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Consumer<Globals>(
          builder: (context, globals, child) {
            return ListBody(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: globals.appointments.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final appointment = snapshot.data.docs;
                      List<AppointmentCard> appointmentCardWidgets = [];
                      for (var appointments in appointment) {
                        final appointmentPlace =
                            appointments.data()['placeOfAppointment'];
                        final appointmentTime =
                            appointments.data()['appointmentTime'];
                        final appointmentDate =
                            appointments.data()['dateOfAppointment'];
                        final appointmentBookedBy =
                            appointments.data()['appointmentBookedBy'];
                        final appointmentBookedWith =
                            appointments.data()['appointmentBookedWith'];
                        final appointmentCardWidget = AppointmentCard(
                            doctorSpeciality: 'Cardiologist',
                            doctorName: 'Jaspreet',
                            appointmentDate: '$appointmentDate',
                            appointmentPlace: '$appointmentPlace',
                            appointmentTime: '$appointmentTime');
                        appointmentCardWidgets.add(appointmentCardWidget);
                        print(appointmentBookedBy);
                        print(appointmentBookedWith);
                      }

                      return Column(
                        children: appointmentCardWidgets,
                      );
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 180),
                      child: NoDataComponent(
                          title: 'You don\'t have any appointments yet.'),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpeciality;
  final String appointmentDate;
  final String appointmentPlace;
  final String appointmentTime;
  AppointmentCard(
      {@required this.doctorSpeciality,
      @required this.doctorName,
      @required this.appointmentDate,
      @required this.appointmentPlace,
      @required this.appointmentTime});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kPageHorizontalPadding, vertical: kPageVerticalPadding),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kPageHorizontalPadding * 1.5,
            vertical: kPageVerticalPadding * 1.5),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(kRoundedCorners),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/userImage.jpg'),
                  radius: 30.0,
                ),
                SizedBox(
                  width: kPageHorizontalPadding,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. $doctorName',
                      overflow: TextOverflow.ellipsis,
                      style: kSubHeadingTextStyle.copyWith(
                          fontSize: 18.0, color: Colors.white),
                    ),
                    Text(doctorSpeciality,
                        style:
                            kSecondaryTextStyle.copyWith(color: Colors.white70))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: kPageVerticalPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style:
                          kSecondaryTextStyle.copyWith(color: Colors.white70),
                    ),
                    Text(
                      appointmentDate,
                      style: kRichTextStyle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Place',
                      style:
                          kSecondaryTextStyle.copyWith(color: Colors.white70),
                    ),
                    Text(
                      appointmentPlace,
                      style: kRichTextStyle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: kPageVerticalPadding,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRoundedCorners),
                  color: Colors.black38),
              padding: EdgeInsets.symmetric(
                  horizontal: kPageHorizontalPadding * 1.5,
                  vertical: kPageVerticalPadding / 2),
              child: Text(
                appointmentTime,
                style: kRichTextStyle1.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
