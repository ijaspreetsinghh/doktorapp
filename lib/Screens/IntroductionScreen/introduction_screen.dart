import 'package:doktorapp/Screens/SignIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  static const id = 'OnboardingScreen';
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.id, (route) => false);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.jpg',fit: BoxFit.cover,),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [ PageViewModel(
        title: "Welcome to Doctor App",
        body: "Appointment Booking System with Flutter and Firebase.",
        image: _buildImage('logo'),

        decoration: pageDecoration,
      ),
        PageViewModel(
          title: "Home Page",
          body:
              "Homepage consists of categories and top doctor from all categories.",
          image: _buildImage('on1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Category View",
          body:
              "All specialists of specific category.",
          image: _buildImage('on3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Doctor details",
          body:
              "Preview doctor details and book appointment if interested.",
          image: _buildImage('on2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Appointment booking screen",
          body: "Select prefered date and time and pre appointment details.",
          image: _buildImage('on4'),

          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
