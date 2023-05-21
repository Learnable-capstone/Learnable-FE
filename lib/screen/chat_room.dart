import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import '../const/colors.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _textEditingController = TextEditingController();
  final int _maxTextLength = 15;

  int _selectedTag = 0; // 선택된 태그 인덱스

  List<String> _tagImages = [
    'assets/images/tag0_off.png',
    'assets/images/tag1_off.png',
    'assets/images/tag2_off.png',
    'assets/images/tag3_off.png',
    'assets/images/tag4_off.png',
    'assets/images/tag5_off.png',
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
              "채팅방 추가",
              style: MyTextStyle.CbS30W500,
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
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "완료",
                  style: MyTextStyle.CgS70W500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bubble.png',
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/images/chatbotCharacter2_1.png',
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: '채팅방 제목을 입력해주세요.',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              maxLength: _maxTextLength,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Text(
              '주제설정(택1)',
              textAlign: TextAlign.start,
              style: MyTextStyle.CbS15W700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 3; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTag = i;
                    });
                  },
                  child: Image.asset(
                    _selectedTag == i
                        ? _tagImages[i].replaceAll('_off', '')
                        : _tagImages[i],
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 3; i < _tagImages.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTag = i;
                    });
                  },
                  child: Image.asset(
                    _selectedTag == i
                        ? _tagImages[i].replaceAll('_off', '')
                        : _tagImages[i],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
