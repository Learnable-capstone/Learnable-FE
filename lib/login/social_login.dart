import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../const/colors.dart';
import '../const/text_style.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 164),
                _bigText(),
                _bigText2(),
                _chatbotCharacter()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _GPTeacher() {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/images/GPTeacher.png',
    ),
  );
}
Widget _chatbotCharacter() {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/images/chatbotCharacter1.png',
      fit: BoxFit.cover,
    ),
  );
}

Widget _bigText() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      '당신의 컴퓨터공학 학습파트너',
      style: MyTextStyle.CgrS20W800,
      textAlign: TextAlign.center,
    ),
  );
}

Widget _bigText2() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      'GPTeacher',
      style: MyTextStyle.CgrS70W700,
      textAlign: TextAlign.center,
    ),
  );
}