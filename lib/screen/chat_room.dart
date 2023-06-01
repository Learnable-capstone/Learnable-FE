import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import '../const/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _textEditingController = TextEditingController();
  final int _maxTextLength = 15;
  var title;
  var subjectId = 1;

  int _selectedTag = 0; // 선택된 태그 인덱스

  final List<String> _tagImages = [
    'assets/images/tag1_off.png',
    'assets/images/tag2_off.png',
    'assets/images/tag3_off.png',
    'assets/images/tag4_off.png',
    'assets/images/tag5_off.png',
    'assets/images/tag6_off.png',
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void newChatroom() async {
    final FlutterSecureStorage _storage = const FlutterSecureStorage();
    String? userId = await _storage.read(key: 'userId');
    var url = Uri.parse('http://43.201.186.151:8080/chatrooms');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'memberId': userId,
        'subjectId': subjectId,
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      print('Successful POST request');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (String image in _tagImages) {
      precacheImage(AssetImage(image), context);
    }
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
            actions: [
              TextButton(
                onPressed: () {
                  newChatroom();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                },
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
              onChanged: (text) {
                print(_textEditingController.text);
                setState(() {
                  title = _textEditingController.text;
                  print(title);
                });
              },
              controller: _textEditingController,
              decoration: const InputDecoration(
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
                      subjectId = _selectedTag + 1;

                      print(subjectId);
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
                      subjectId = _selectedTag + 1;
                      print(subjectId);
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
