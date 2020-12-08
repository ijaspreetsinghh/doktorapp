import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:ui';

class NoDataComponent extends StatelessWidget {
  NoDataComponent({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nodata.png',
              width: 225.0,
            ),
            Text(
              title,
              style: kRichTextStyle1.copyWith(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
