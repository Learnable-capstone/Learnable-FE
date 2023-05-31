import 'package:flutter/material.dart';
import 'package:learnable/onboarding/tutorial_screen.dart';
import 'package:learnable/onboarding/tutorial_tabbar.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'const/colors.dart';
import 'const/input_decoration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'a6a4ca0c5ad1108a299a8d7ba5cf68de',
  );

  // secure storage 인스턴스 생성
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /****************테스트용*************/
  //await _storage.delete(key: 'userId'); // 저장된 UserId 삭제

  // 저장된 UserId 불러오기
  String? userId = await _storage.read(key: 'userId');

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userId != null) {
      // UserId가 null이 아닌 경우 메인 화면으로 이동
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
        home: const MainScreen(),
      );
    } else {
      // UserId가 null인 경우 튜토리얼 탭바 화면으로 이동
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
}
