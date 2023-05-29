import 'dart:ui';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:learnable/login/login_platform.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import '../const/button_style.dart';
import '../const/colors.dart';
import '../const/text_style.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  Future signwithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double imageScaleFactor = screenWidth > 500 ? 1.0 : 0.5;
    double imageSizeGPTeacher = 500 * imageScaleFactor;
    double imageSizeChatbot = 500 * imageScaleFactor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: MyColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.2),
                  _bigText(),
                  _bigText2(),
                  if (screenWidth > 500) _GPTeacher(),
                  _chatbotCharacter(),
                  SizedBox(height: screenHeight * 0.2),
                  _kakaoLogin(),
                  SizedBox(height: screenHeight * 0.02),
                  _appleLogin(),
                  SizedBox(height: screenHeight * 0.01),
                  _googleLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
        child: Image.asset('assets/images/titleText.png'));
  }

  Widget _kakaoLogin() {
    return GestureDetector(
      onTap: signwithKakao,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/Kakao Login.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _appleLogin() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  "준비중인 기능입니다!",
                  style: MyTextStyle.CbS15W700,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      child: Text("확인"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/Apple Login.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _googleLogin() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/Google Login.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
