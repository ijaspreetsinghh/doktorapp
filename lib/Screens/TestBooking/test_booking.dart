import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/components.dart';

class TestBooking extends StatefulWidget {
  static const id = 'TestBooking';

  @override
  _TestBookingState createState() => _TestBookingState();
}

class _TestBookingState extends State<TestBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Booking',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You haven\'t booked any test.',
      ),
    );
  }
}
