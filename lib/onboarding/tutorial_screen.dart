import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const/button_style.dart';
import '../const/text_style.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 121),
                  _tab(),
                  const SizedBox(height: 95),
                  _rectangle6(),
                  _rectangle7(),
                  const SizedBox(height: 51),
                  _bigText(),
                ],
              ),
              _nextButton()
              // _tutorialImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab() {
    return Container(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/tab1.svg',
      ),
    );
  }
  Widget _rectangle6() {
    return Container(
      margin: EdgeInsets.only(left: 87),
      alignment: Alignment.topLeft,
      child: Image.asset(
        'assets/images/Rectangle6.png',
      ),
    );
  }
  Widget _rectangle7() {
    return Container(

      margin: EdgeInsets.only(right: 65),
      alignment: Alignment.bottomRight,
      child: Image.asset(
        'assets/images/Rectangle7.png',
      ),
    );
  }

  Widget _bigText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '채팅만으로 쉽게\n컴퓨터 지식을 학습해봐요!',
        style: MyTextStyle.CbS23W700,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _nextButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: () {
        },
        style: MyButtonStyle.nextButtonStyle,
        child: Text(
          '시작하기',
          style: MyTextStyle.CwS30W700,
        ),
      ),
    );
  }
}
