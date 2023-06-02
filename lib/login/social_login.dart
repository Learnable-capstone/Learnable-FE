import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:learnable/screen/agreement_screen.dart';
import 'package:learnable/login/login_platform.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../const/button_style.dart';
import '../const/colors.dart';
import '../const/text_style.dart';
import 'package:intl/intl.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'userId', value: userId);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgreementScreen()),
    );
  }

  String generateUniqueNumber() {
    DateTime now = DateTime.now();
    String timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    String uniqueNumber = 'guest_$timestamp';
    return uniqueNumber;
  }

  Future<void> signin(
      String socialId, String socialType, String? name, String? email) async {
    var url = Uri.parse('http://43.201.186.151:8080/user/login');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'username': name,
        'email': email,
        'socialType': socialType,
        'socialId': socialId.toString(),
        'profileIdx': 0
      }),
    );

    if (response.statusCode == 200) {
      print('Successful POST request');
      var responseData = jsonDecode(response.body);
      var userId = responseData["userId"];
      saveUserId(userId.toString());
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

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
      print(profileInfo["id"].toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
      signin(profileInfo["id"].toString(), "kakao",
          profileInfo["properties"]["nickname"], null);
      //await saveUserId(1.toString());
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  Future signwithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      signin(googleUser.id.toString(), "google", googleUser.displayName,
          googleUser.email);

      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
  }

  Future signwithApple() async {
    try {
      final AuthorizationCredentialAppleID credentialAppleID =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "learnable.example.com",
          redirectUri: Uri.parse(
              "https://concrete-billowy-emmental.glitch.me/callbacks/sign_in_with_apple"),
        ),
      );
      print('credential.state = $credentialAppleID');
      print('credential.state = ${credentialAppleID.email}');
      print('credential.state = ${credentialAppleID.userIdentifier}');

      setState(() {
        _loginPlatform = LoginPlatform.apple;
      });
      signin(credentialAppleID.userIdentifier.toString(), "apple",
          credentialAppleID.givenName, credentialAppleID.email);
    } catch (error) {
      print('error = $error');
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

    await _storage.delete(key: 'userId'); // 저장된 UserId 삭제

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
                  SizedBox(height: screenHeight * 0.17),
                  _bigText(),
                  _bigText2(),
                  if (screenWidth > 500) _GPTeacher(),
                  _chatbotCharacter(),
                  SizedBox(height: screenHeight * 0.2),
                  _kakaoLogin(),
                  SizedBox(height: screenHeight * 0.01),
                  _appleLogin(),
                  SizedBox(height: screenHeight * 0.01),
                  _googleLogin(),
                  TextButton(
                      onPressed: () {
                        String tmpid = generateUniqueNumber();
                        signin(tmpid, "guest", "게스트", null);
                      },
                      child: Text(
                        "게스트 로그인",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
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
        'assets/images/titleText.png',
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
        signwithApple();
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
    return GestureDetector(
      onTap: () {
        signwithGoogle();
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
