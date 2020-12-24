import 'dart:async';

import 'package:doktorapp/Screens/ForgotPassword/forgot_password.dart';
import 'package:doktorapp/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:doktorapp/Screens/SignUp/sign_up_screen.dart';
import 'package:doktorapp/Screens/Profile/main_profile_page.dart';
import 'package:doktorapp/Screens/Appointment/active_appointment.dart';
import 'package:doktorapp/Screens/Consultation/consultation.dart';
import 'package:doktorapp/Screens/MedicalRecord/medical_record.dart';
import 'package:doktorapp/Screens/MyDoctor/my_doctor.dart';
import 'package:doktorapp/Screens/Orders/orders.dart';
import 'package:doktorapp/Screens/Profile/doctor_profile_view.dart';
import 'package:doktorapp/Screens/Reminder/reminder.dart';
import 'package:doktorapp/Screens/TestBooking/test_booking.dart';
import 'package:doktorapp/Screens/UserProfileInfo/user_profile_info.dart';
import 'package:doktorapp/Screens/IntroductionScreen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/SignUp/sign_up_continue.dart';
import 'globals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          AppLoading();

          return MyMaterialApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return AppLoading();
      },
    );
  }
}

class MyMaterialApp extends StatefulWidget {
  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return Provider<Globals>(
        create: (_) => Globals(),
        child: Consumer<Globals>(builder: (context, globals, child) {
          globals.getDoctorData();
          globals.getUserData();
          globals.getCurrentUser();
          globals.getAppointments();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: kPrimaryColor,
            initialRoute:
                globals.userLoggedIn ? MainProfilePage.id : OnBoardingPage.id,
            routes: {
              SignUpContinue.id: (context) => SignUpContinue(),
              ForgotPassword.id: (context) => ForgotPassword(),
              OnBoardingPage.id: (context) => OnBoardingPage(),
              SignInScreen.id: (context) => SignInScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              MainProfilePage.id: (context) => MainProfilePage(),
              ActiveAppointment.id: (context) => ActiveAppointment(),
              Consultation.id: (context) => Consultation(),
              MedicalRecord.id: (context) => MedicalRecord(),
              MyDoctor.id: (context) => MyDoctor(),
              Reminder.id: (context) => Reminder(),
              Orders.id: (context) => Orders(),
              TestBooking.id: (context) => TestBooking(),
              UserProfileInfo.id: (context) => UserProfileInfo(),
            },
            theme: ThemeData().copyWith(
              primaryColor: kPrimaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: kBackgroundColor,
            ),
          );
        }));
  }
}

class AppLoading extends StatefulWidget {
  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
