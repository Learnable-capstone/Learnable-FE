import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnable/screen/chat_screen.dart';
import '../const/colors.dart';
import '../const/text_style.dart';
import 'chat_room.dart';
import 'user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var chatRoom = [];

  Future<void> getChatRoom() async {
    var result = await http
        .get(Uri.parse('http://43.201.186.151:8080/chatrooms?memberId=1'));
    var resultJson = jsonDecode(utf8.decode(result.bodyBytes));
    setState(() {
      for (var i = 0; i < resultJson['data']['chatRoomResponses'].length; i++) {
        chatRoom.add({
          'title': resultJson['data']['chatRoomResponses'][i]['title'],
          'subjectId': resultJson['data']['chatRoomResponses'][i]['subjectId']
        });
      }
      print(resultJson['data']['chatRoomResponses'].length);
    });
  }

  @override
  void initState() {
    super.initState();
    getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/backgroundMain.svg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 160),
                        child: Container(
                          child: _dog(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(right: 56),
                        child: Container(
                          child: _chatbot(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _textBox(),
              const SizedBox(height: 26),
              _floatingButton(),
              Expanded(
                child: _chatList(),
              )
            ],
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
              onPressed: () {},
              iconSize: 40,
              color: Color(0xFF7AC38F),
            ),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {},
              iconSize: 40,
              color: Color(0xCFE0FFD9),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              },
              iconSize: 40,
              color: Color(0xCFE0FFD9),
            )
          ],
        ),
      ),
    );
  }

  Widget _dog() {
    return Image.asset(
      'assets/images/dog.png',
    );
  }

  Widget _chatbot() {
    return Image.asset(
      'assets/images/chatbot_Character 2.png',
    );
  }

  Widget _textBox() {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/textBackground.png',
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '안녕하세요, 러너블 님!\n 오늘의 학습을 시작해볼까요?',
                style: MyTextStyle.CbS15W700,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingButton() {
    return Container(
      margin: EdgeInsets.only(right: 18),
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatRoom()),
          );
        },
        child: Image.asset(
          'assets/images/Add Btn.png',
          width: 50,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      itemCount: chatRoom.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                chatRoom[index]['title'].toString(),
                style: MyTextStyle.CbS15W700,
              ),
              leading: Image.asset(
                'assets/images/tag' +
                    chatRoom[index]['subjectId'].toString() +
                    '.png',
                width: 90,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print('Item ${index + 1} is clicked.');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      title: chatRoom[index]['title'].toString(),
                      subjectId: chatRoom[index]['subjectId'].toString(),
                    ),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
