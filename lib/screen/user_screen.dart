import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import 'package:learnable/screen/main_screen.dart';
import '../const/colors.dart';

class UserScreen extends StatelessWidget {
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: MyColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Flexible(
                      child: Image.asset('assets/images/dog.png'), flex: 3),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "러너블",
                          style: MyTextStyle.CbS23W700,
                        ),
                        Text(
                          "가입일: 2023.03.18",
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
                            builder: (context) => ProfileEditScreen(),
                          ),
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
            InkResponse(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
              child: Icon(Icons.home, size: 40, color: Color(0xCFE0FFD9)),
            ),
            InkResponse(
              onTap: () {},
              child: Icon(Icons.bookmark, size: 40, color: Color(0xCFE0FFD9)),
            ),
            InkResponse(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                  (route) => false,
                );
              },
              child: Icon(Icons.person, size: 40, color: Color(0xFF7AC38F)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("프로필 수정"),
      ),
      body: Center(
        child: Text("프로필 수정 화면"),
      ),
    );
  }
}
