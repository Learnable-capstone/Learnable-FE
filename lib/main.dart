import 'package:flutter/material.dart';
import 'package:learnable/onboarding/tutorial_screen.dart';
import 'package:learnable/onboarding/tutorial_tabbar.dart';

import 'const/colors.dart';
import 'const/input_decoration.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Spoqa',
        scaffoldBackgroundColor: MyColors.white,
        inputDecorationTheme: MyInputDecorationTheme.defaultInputDecoration,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: MyColors.black),
          shadowColor: Colors.transparent,
          color: Colors.transparent,
        ),
        primarySwatch: Colors.green,
      ),
      home: TutorialTabbar(),
    );
  }
}
