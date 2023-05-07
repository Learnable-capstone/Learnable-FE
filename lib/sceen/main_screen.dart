import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnable/sceen/chat_screen.dart';
import '../const/colors.dart';
import '../const/text_style.dart';
import 'chat_room.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var data =[1,2,3,4];

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
                          // 첫번째 위젯 설정
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
              Expanded( // ListView 추가
                child: _chatList(),
              )
            ],
          ),
        ],
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
          Image.asset(
            'assets/images/textBackground.png',
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Text(
                'Hello, World!',
                style: MyTextStyle.CbS23W700,
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
        child: Image.asset('assets/images/Add Btn.png'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(data[index].toString()), // 리스트뷰 아이템의 제목
          subtitle: Text('Subtitle ${index + 1}'), // 리스트뷰 아이템의 부제목
          leading: CircleAvatar(child: Text('${index + 1}')), // 리스트뷰 아이템의 왼쪽에 표시되는 아이콘
          trailing: Icon(Icons.arrow_forward_ios), // 리스트뷰 아이템의 오른쪽에 표시되는 아이콘
          onTap: () {
            // 리스트뷰 아이템을 클릭했을 때 수행되는 동작
            print('Item ${index + 1} is clicked.');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ChatScreen()),
            );
          },
        );
      },
    );
  }
}
