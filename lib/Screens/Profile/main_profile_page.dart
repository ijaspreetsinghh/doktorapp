import 'dart:async';

import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:doktorapp/globals.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'drawer_page.dart';
import 'profile_page_content.dart';
import 'package:doktorapp/Screens/Profile/profile_page_content.dart';
import 'package:flushbar/flushbar.dart';

class MainProfilePage extends StatefulWidget {
  static const id = 'ProfilePage';
  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool _saving = true;
  @override
  void initState() {
    Timer(Duration(seconds: 3), loader);
    super.initState();
  }

  void loader() {
    setState(() {
      _saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        color: Colors.black,
        dismissible: false,
        inAsyncCall: _saving,
        opacity: 0.7,
        child: Consumer<Globals>(builder: (context, globals, child) {
          globals.getUserData();
          globals.getCategories();
          globals.getUserData();
          globals.getDoctorData();
          globals.getAppointments();

          return DoubleBack(
            onFirstBackPress: (context) {
              Flushbar(
                message: "Press back again to exit",
                duration: Duration(seconds: 3),
                animationDuration: Duration(milliseconds: 500),
              )..show(context);
            },
            child: Scaffold(
              backgroundColor: kWhiteBackgroundColor,
              appBar: AppBar(
                backgroundColor: kWhiteBackgroundColor,
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Icon(
                        Icons.search_rounded,
                        size: 30.0,
                      ))
                ],
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              drawer: DrawerPage(),
              body: ProfilePageContent(),
            ),
          );
        }));
  }
}
