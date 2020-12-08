import 'package:doktorapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doktorapp/components.dart';

class ActiveAppointment extends StatefulWidget {
  static const id = 'ActiveAppointment';
  @override
  _ActiveAppointmentState createState() => _ActiveAppointmentState();
}

class _ActiveAppointmentState extends State<ActiveAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You have no appointments.',
      ),
    );
  }
}
