import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/components.dart';

class MyDoctor extends StatefulWidget {
  static const id = 'MyDoctor';

  @override
  _MyDoctorState createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Doctors',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You haven\'t bookmarked any doctor.',
      ),
    );
  }
}
