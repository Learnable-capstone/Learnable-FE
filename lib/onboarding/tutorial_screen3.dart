import 'package:flutter/material.dart';
import 'tutorial_screen3.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const/button_style.dart';
import '../const/text_style.dart';
import 'package:learnable/login/social_login.dart';

class TutorialScreen3 extends StatefulWidget {
  const TutorialScreen3({Key? key}) : super(key: key);

  @override
  State<TutorialScreen3> createState() => _TutorialScreen3State();
}

class _TutorialScreen3State extends State<TutorialScreen3> {
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
                  _fire(),
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
        'assets/images/tab3.svg',
      ),
    );
  }
  Widget _fire() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/fire.png',
      ),
    );
  }

  Widget _bigText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '복습도\n챗봇과 함께 철저하게!',
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SocialLogin()),
          );
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

