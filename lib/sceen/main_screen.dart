import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../const/colors.dart';
import '../const/text_style.dart';
import 'chat_room.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
              //_chatList()
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
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text('ListTile Hero')),
                body: Center(
                  child: Hero(
                    tag: 'ListTile-Hero',
                    child: Material(
                      child: ListTile(
                        title: Text(i.toString()),
                        subtitle: const Text('Tap here to go back'),
                        tileColor: Colors.blue[700],
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },title: Column(),
      );
    }));
  }
}
