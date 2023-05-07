import 'package:flutter/material.dart';
import 'tutorial_screen3.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const/button_style.dart';
import '../const/text_style.dart';

class TutorialScreen2 extends StatefulWidget {
  const TutorialScreen2({Key? key}) : super(key: key);

  @override
  State<TutorialScreen2> createState() => _TutorialScreen2State();
}

class _TutorialScreen2State extends State<TutorialScreen2> {
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
                  _qeustionMark(),
                  _qeustionMark2(),
                  const SizedBox(height: 51),
                  _bigText(),
                ],
              ),
              // _nextButton()
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
        'assets/images/tab2.svg',
      ),
    );
  }
  Widget _qeustionMark() {
    return Container(
      margin: const EdgeInsets.only(left: 115),
      alignment: Alignment.topLeft,
      child: Image.asset(
        'assets/images/Question Mark.png',
      ),
    );
  }
  Widget _qeustionMark2() {
    return Container(

      margin: const EdgeInsets.only(right: 107),
      alignment: Alignment.bottomRight,
      child: Image.asset(
        'assets/images/Question Mark2.png',
      ),
    );
  }

  Widget _bigText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '모르는 게 있다면\n챗봇에게 물어봐요',
        style: MyTextStyle.CbS23W700,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget _nextButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 54,
  //     child: TextButton(
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => TutorialScreen3()),
  //         );
  //       },
  //       style: MyButtonStyle.nextButtonStyle,
  //       child: Text(
  //         '시작하기',
  //         style: MyTextStyle.CwS30W700,
  //       ),
  //     ),
  //   );
  // }
}

