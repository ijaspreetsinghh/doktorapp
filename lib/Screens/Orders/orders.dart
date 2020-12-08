import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:doktorapp/components.dart';

class Orders extends StatefulWidget {
  static const id = 'Orders';

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kWhiteBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: NoDataComponent(
        title: 'You haven\'t ordered anything.',
      ),
    );
  }
}
