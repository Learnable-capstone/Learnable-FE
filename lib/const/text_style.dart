import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextStyle {
  static TextStyle CwS30W700 = TextStyle(
    color: MyColors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle CbS30W700 = TextStyle(
    color: MyColors.black,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle CbS23W700 = TextStyle(
    color: MyColors.black,
    fontSize: 23,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle CgrS20W800 = TextStyle(
    color: MyColors.green800,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle CgS16W500 = TextStyle(
    color: MyColors.gray500,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static TextStyle CgrS70W700 = TextStyle(
    color: MyColors.green700,
    fontSize: 70,
    fontWeight: FontWeight.w700,
    height: 1.2,
    foreground: Paint()
      ..strokeWidth = 2.0
      ..color = MyColors.green600,
  );
}