import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/components.dart';

class Reminder extends StatefulWidget {
  static const id = 'Reminder';

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You haven\'t set any reminder.',
      ),
    );
  }
}
