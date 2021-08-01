import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
//Layout
final kSpacingUnit = 10.w;

//Color Schemes
const kBlackColor = Color(0xFF121212);
const kGreenColor = Color(0xFF1DB954);
const kBottomNavColor = Color(0xFF282828);
const kDarkGreyColor = Color(0xFF2A2A2A);
const kGreyColor = Color(0xFFC4C4C4);
const kTextColor = Color(0xFFFAFAFA);
const kSecondaryTextColor = Color(0xFFAEAEAE);

class AppColors {
  static const mainColor = Color(0XFFe5eefc);
  static const styleColor = Color(0XFF6f7e96);
  static const activeColor = Color(0XFFd0ddf3);
  static const lightBlue = Color(0XFF92aeff);
  static const darkBlue = Color(0XFF5880ff);
  static const lightBlueShadow = Color(0XAA92aeff);
}

class Global {
  static final shared = Global();
  bool isInstructionView = false;
}


//Typography
final kHeadingTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w700,
);

final kTitleTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 17.sp,
  fontWeight: FontWeight.w700,
);

final kSubTitleTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
);

final kBodyTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
);

final kCaptionTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
);

final kNavTitleTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 8.sp,
  fontWeight: FontWeight.w400,
);
