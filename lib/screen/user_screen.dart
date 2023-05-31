import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:learnable/screen/profile_edit_screen.dart';
import 'package:learnable/login/social_login.dart';
import '../const/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  final String? nickname;
  final int profileIdx;
  final String? createdAt;

  const UserScreen({
    Key? key,
    required this.nickname,
    required this.profileIdx,
    required this.createdAt,
  }) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<String> imageList = [
    'assets/images/fox.png',
    'assets/images/dog.png',
    'assets/images/cat.png',
    'assets/images/robot.png',
    'assets/images/boiled_egg.png',
    'assets/images/fried_egg.png'
  ];

  Future<void> withdraw() async {
    String? userId;
    final FlutterSecureStorage _storage = const FlutterSecureStorage();

    // 저장된 UserId 불러오기
    userId = await _storage.read(key: 'userId');
    if (userId != null) {
      var result = await http
          .delete(Uri.parse('http://43.201.186.151:8080/user/$userId'));
    }
    ;
    return;
  }

  Future<void> showWithdrawalConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회원 탈퇴'),
          content: Text('탈퇴하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                withdraw();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => (SocialLogin())),
                );
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: AppBar(
            centerTitle: true,
            elevation: 8,
            title: Text(
              "마이페이지",
              style: MyTextStyle.CbS23W700,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Flexible(
                    child: Image.asset(imageList[widget.profileIdx]),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.nickname}",
                          style: MyTextStyle.CbS23W700,
                        ),
                        Text(
                          "가입일: ${widget.createdAt}",
                          style: MyTextStyle.CgS16W500,
                        ),
                      ],
                    ),
                    flex: 7,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(
                        height: 20, thickness: 5, color: Color(0xFFEFEFEF)),
                    ListTile(
                      title: Text(
                        "프로필 수정",
                        style: MyTextStyle.CbS20W500,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditScreen(
                                    nickname: widget.nickname,
                                    profileIdx: widget.profileIdx,
                                  )),
                        );
                      },
                    ),
                    const Divider(
                        height: 10, thickness: 5, color: Color(0xFFEFEFEF)),
                    ListTile(
                      title: Text(
                        "서비스 이용약관",
                        style: MyTextStyle.CbS20W500,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    ListTile(
                      title: Text(
                        "개인정보 처리방침",
                        style: MyTextStyle.CbS20W500,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    ListTile(
                      title: Text(
                        "버전",
                        style: MyTextStyle.CbS20W500,
                      ),
                      trailing: Text(
                        "v1.0.0",
                        style: MyTextStyle.CgS16W500,
                      ),
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    ListTile(
                      title: Text(
                        '회원 탈퇴',
                        style: MyTextStyle.CbS20W500,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap:
                          showWithdrawalConfirmationDialog, // Call the withdrawal confirmation dialog
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color(0xFFB1E9A3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              iconSize: 40,
              color: Color(0xCFE0FFD9),
            ),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {},
              iconSize: 40,
              color: Color(0xCFE0FFD9),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
              iconSize: 40,
              color: Color(0xFF7AC38F),
            )
          ],
        ),
      ),
    );
  }
}
