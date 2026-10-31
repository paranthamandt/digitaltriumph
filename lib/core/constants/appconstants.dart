import 'package:flutter/cupertino.dart';

enum ViewState {
  initial,
  loading,
  success,
  empty,
  error,
}



class Appconstants {
  static String appname="my first app";
  static EdgeInsets Padding=EdgeInsets.all(16.0);
  static double defaultBorderRadius=12.0;
  static const String userHiveBox="userbox";

  static const EdgeInsets marginTop=EdgeInsets.only(top: 40);
  static const EdgeInsets marginsmall=EdgeInsets.only(top: 8);
  static const EdgeInsets marginmedium=EdgeInsets.only(top: 20);
  static const EdgeInsets marginlarge=EdgeInsets.only(top: 32);

}