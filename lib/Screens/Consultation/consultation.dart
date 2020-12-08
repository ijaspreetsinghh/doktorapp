import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/components.dart';

class Consultation extends StatefulWidget {
  static const id = 'Consultation';
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Online Consultation',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You haven\'t had any consultation.',
      ),
    );
  }
}
