import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';

class AppSettings extends StatelessWidget {
  static const id = 'settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          id,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
    );
  }
}
