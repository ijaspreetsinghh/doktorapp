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
                  stream: globals.appointments
                      .where('appointmentBookedBy',
                          isEqualTo: globals.currentUserId)
                      .orderBy(
                        'created',
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      final appointment = snapshot.data.docs;

                      List<AppointmentCard> appointmentCardWidgets = [];
                      for (var appointments in appointment) {
                        final appointmentPlace =
                            appointments.data()['placeOfAppointment'];
                        final appointmentTime =
                            appointments.data()['appointmentTime'];
                        final doctorSpecialityDb =
                            appointments.data()['doctorSpeciality'];
                        final doctorNameDb = appointments.data()['doctorName'];
                        final appointmentDateDD =
                            appointments.data()['dateOfAppointment']['date'];
                        final appointmentDateMM =
                            appointments.data()['dateOfAppointment']['month'];
                        final appointmentDateYY =
                            appointments.data()['dateOfAppointment']['year'];
                        final appointmentBookedBy =
                            appointments.data()['appointmentBookedBy'];
                        final appointmentBookedWith =
                            appointments.data()['appointmentBookedWith'];
                        final doctorAvatar =
                        appointments.data()['doctorAvatar'];
                        final appointmentDate =
                            '$appointmentDateDD/$appointmentDateMM/$appointmentDateYY';
                        final appointmentCardWidget = AppointmentCard(
                            doctorSpeciality: doctorSpecialityDb,
                            doctorName: doctorNameDb,
                            doctorAvatar: doctorAvatar,
                            appointmentDate: '$appointmentDate',
                            appointmentPlace: '$appointmentPlace',
                            appointmentTime: '$appointmentTime');
                        appointmentCardWidgets.add(appointmentCardWidget);
                        print(appointmentBookedBy);
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
  final String doctorAvatar;
  final String appointmentPlace;
  final String appointmentTime;
  AppointmentCard(
      {@required this.doctorSpeciality,
      @required this.doctorName,
        @required this.doctorAvatar,
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
                  backgroundImage: NetworkImage(doctorAvatar),
                  radius: 30.0,
                ),
                SizedBox(
                  width: kPageHorizontalPadding,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. $doctorName',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: kSubHeadingTextStyle.copyWith(
                            fontSize: 18.0, color: Colors.white),
                      ),
                      Text(doctorSpeciality,
                          style: kSecondaryTextStyle.copyWith(
                              color: Colors.white70))
                    ],
                  ),
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRoundedCorners),
                          color: Colors.black38),
                      padding: EdgeInsets.symmetric(
                          horizontal: kPageHorizontalPadding * 1,
                          vertical: kPageVerticalPadding / 3),
                      child: Text(
                        appointmentDate,
                        style: kRichTextStyle1.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time',
                      style:
                          kSecondaryTextStyle.copyWith(color: Colors.white70),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRoundedCorners),
                          color: Colors.black38),
                      padding: EdgeInsets.symmetric(
                          horizontal: kPageHorizontalPadding * 1,
                          vertical: kPageVerticalPadding / 3),
                      child: Text(
                        appointmentTime,
                        style: kRichTextStyle1.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
