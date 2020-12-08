import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kNameTextStyle = TextStyle(
    fontSize: 18.0, fontFamily: kFontFamily, fontWeight: FontWeight.w700);
const kRoundedCorners = 15.0;
const kBigHeadingTextStyle = TextStyle(
    fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: kFontFamily);
const kSubHeadingTextStyle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: kFontFamily);
const kLabelTextStyle =
    TextStyle(color: kAccentColor, fontSize: 15.0, fontFamily: kFontFamily);
const kSecondaryTextStyle = TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.w900,
    fontSize: 14.0,
    fontFamily: kFontFamily);
const kHintTextStyle = TextStyle(
  fontFamily: kFontFamily,
  color: kSecondaryColor,
);
const kRichTextStyle1 = TextStyle(
  color: Colors.black,
  fontFamily: kFontFamily,
  fontSize: 14.0,
);

const kMenuItemTextStyle =
    TextStyle(fontFamily: kFontFamily, fontWeight: FontWeight.bold);
const kAccentTextStyle = TextStyle(
    color: kAccentColor,
    fontFamily: kFontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.bold);

const kPrimaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment
      .bottomRight, //Alignment(0.8, 1.5), 10% of the width, so there are ten blinds.
  colors: [
    const Color(0xff00d2ff),
    const Color(0xFF1482FF)
  ], // red to yellow 0xff005ce6
  // repeats the gradient over the canvas
);
const kRichTextStyle2 = TextStyle(
    color: kPrimaryColor, fontFamily: kFontFamily, fontWeight: FontWeight.bold);
const kPrimaryColor = Color(0xFF1482FF); //005EFF or 0066ff  0xFF005CE6
const kBorderColor = Color(0xFFE71D36);
const kTitleColor = Color(0xFF2E2D2D);
const kAccentColor = Color(0xFF1482FF);
const kSecondaryColor = Color(0xFF555555); //008DFF
const kBackgroundColor = Color(0xFFF7F7F7);
const kWhiteBackgroundColor = Colors.white;
const kFormIconSize = 25.0;
const kLargeCircleAvatarRadius = 70.0;
const kMediumCircleAvatarRadius = 30.0;
const kSocialSignButtonWidth = 40.0;
const kSocialSignButtonHeight = 40.0;
const kPageHorizontalPadding = 16.0;
const kPageVerticalPadding = 10.0;
const kSocialSizedBoxDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.circle,
);
const kFontFamily = 'Poppins';
const kDrawerListItemTrailingIconSize = 16.0;
