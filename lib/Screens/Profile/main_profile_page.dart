import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:doktorapp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'drawer_page.dart';
import 'profile_page_content.dart';
import 'package:doktorapp/Screens/Profile/profile_page_content.dart';

class MainProfilePage extends StatefulWidget {
  static const id = 'ProfilePage';
  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool _saving = false;

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

          return Scaffold(
            backgroundColor: kWhiteBackgroundColor,
            appBar: AppBar(
              backgroundColor: kWhiteBackgroundColor,
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            drawer: DrawerPage(),
            body: ProfilePageContent(),
          );
        }));
  }
}
