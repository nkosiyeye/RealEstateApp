// ignore_for_file: file_names

import 'package:flutter/material.dart';

const String svgPath = 'assets/svg/';

abstract class Constant {

  //Do not add anything here
  static String googlePlaceAPIkey = "";

  ///These task IDs are for load task parallel into the isolate .
  static int? languageTaskId;
  static int? appSettingTaskId;

  ///admob
  static bool isAdmobAdsEnabled = false;

  static bool isNumberWithSuffix = false;
  //Banner


  /////////////////////////////////

  // static late Session session;
  static String currencySymbol = "E";

  //Demo mode settings
  static bool isDemoModeOn = false;
  static String demoCountryCode = "91";
  static String demoMobileNumber = "1234567890";
  static String demoFirebaseID = "6a1Zdl2TxORQGbCazj4XDGfgBBG3";
  static String demoModeOTP = "123456";

  static bool adaptThemeColorSvg = true;

  static const String terminalLogMode = "debug";
}
