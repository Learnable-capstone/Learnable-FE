import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../const/colors.dart';

import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String title;
  final String subjectId;
  final String chatroomId;

  const ChatScreen({
    Key? key,
    required this.title,
    required this.subjectId,
    required this.chatroomId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadMessages();
    });
  }

  Future<void> _fetchBotMessage() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://43.201.186.151:8080/botmessages/${widget.chatroomId}/questions/${widget.subjectId}',
        ),
      );

      if (response.statusCode == 200) {
        var botMessage = utf8.decode(response.bodyBytes);
        setState(() {
          _messages.add({'type': 'bot', 'text': botMessage});
        });
      } else {
        _showErrorMessage('Error occurred while fetching the bot message.');
      }
    } catch (e) {
      _showErrorMessage('Error occurred while fetching the bot message.');
    }
  }

  Future<void> _showAnswer() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://43.201.186.151:8080/botmessages/${widget.chatroomId}/answers',
        ),
      );

      if (response.statusCode == 200) {
        var botMessage = utf8.decode(response.bodyBytes);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '답안 예시',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    botMessage,
                    style: MyTextStyle.CbS15W300,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text("확인"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        _showErrorMessage('Error occurred while loading the answer.');
      }
    } catch (e) {
      _showErrorMessage('Error occurred while loading the answer.');
    }
  }

  Future<void> _loadMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://43.201.186.151:8080/chatrooms/${widget.chatroomId}',
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        var botMessages = (data['data']['botMessages'] as List<dynamic>)
            .map((message) => {
                  'type': 'bot',
                  'text': message['content'],
                  'createdAt': message['createdAt'],
                })
            .toList();

        var userMessages = (data['data']['userMessages'] as List<dynamic>)
            .map((message) => {
                  'type': 'user',
                  'text': message['content'],
                  'createdAt': message['createdAt'],
                })
            .toList();

        var allMessages = [...userMessages, ...botMessages];
        allMessages.sort((a, b) => a['createdAt'].compareTo(b['createdAt']));

        setState(() {
          _messages = allMessages;
        });

        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

        if (_messages.isEmpty) {
          _fetchBotMessage();
        }
      } else {
        _showErrorMessage('Error occurred while loading messages.');
      }
    } catch (e) {
      _showErrorMessage('Error occurred while loading messages.');
    }
  }

  Future<void> _deleteChatRoom() async {
    try {
      final response = await http.delete(
        Uri.parse('http://43.201.186.151:8080/chatrooms/${widget.chatroomId}'),
      );

      if (response.statusCode == 200) {
        // Chat room deleted successfully
        print('Chat room deleted');
      } else {
        _showErrorMessage('Error occurred while deleting the chat room.');
      }
    } catch (e) {
      _showErrorMessage('Error occurred while deleting the chat room.');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add({'type': 'user', 'text': text});
      _loading = true; // Show loading animation
    });
    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(
          'http://43.201.186.151:8080/usermessages/chat?chatroomId=${widget.chatroomId}',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': text.toString(),
        }),
      );

      if (response.statusCode == 200) {
        var answer = utf8.decode(response.bodyBytes);
        setState(() {
          _messages.add({'type': 'bot', 'text': answer});
          _loading = false; // Hide loading animation
        });
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        _showErrorMessage('Error occurred while sending the message.');
      }
    } catch (e) {
      _showErrorMessage('Error occurred while sending the message.');
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isUserMessage = message['type'] == 'user';
    final bool isBotMessage = message['type'] == 'bot';

    final alignment =
        isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor =
        isUserMessage ? Color(0xFFE0FFD9) : Color(0xFFDEF5FF);
    final textColor = Colors.black;
    final borderRadius = isBotMessage
        ? BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          );
    final padding = EdgeInsets.fromLTRB(
      isBotMessage ? 8.0 : 16.0,
      8.0,
      isBotMessage ? 16.0 : 8.0,
      8.0,
    );
    final maxWidth = MediaQuery.of(context).size.width * 0.9;

    final content = Text(
      message['text'],
      style: TextStyle(color: textColor),
    );

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBotMessage)
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Image.asset(
                  "assets/images/chatbot_bubble.png",
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            Expanded(
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: backgroundColor,
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    setState(() {
      _messages.add({
        'type': 'bot',
        'text': message,
      });
    });
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
              title: Column(
                children: [
                  Image.asset(
                    "assets/images/tag" + widget.subjectId + ".png",
                    width: 100,
                  ),
                  Text(
                    widget.title,
                    style: MyTextStyle.CbS23W700,
                  ),
                ],
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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('채팅방 삭제'),
                        content: Text('채팅방을 삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                            child: Text('아니오'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('예'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await _deleteChatRoom();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 40.0,
                  ),
                  color: Colors.grey.shade300,
                ),
              ]),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (_loading) // Show loading animation if _loading is true
            LoadingAnimationWidget.waveDots(
              color: Colors.grey.shade300,
              size: 60,
            ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                margin: EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        _showAnswer();
                      },
                      child: Text(
                        '답안 예시 확인하기',
                        style: MyTextStyle.CgS16W500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _fetchBotMessage();
                      },
                      child: Text(
                        '새로운 질문 확인하기',
                        style: MyTextStyle.CgS16W500,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: '답변을 입력하세요.',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12.0),
                              prefixIcon: Icon(Icons.message,
                                  color: Colors.grey.shade200),
                            ),
                            onSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                _sendMessage(value);
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xFF7AC38F),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF7AC38F).withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_controller.text.trim().isNotEmpty) {
                                _sendMessage(_controller.text);
                              }
                            },
                            icon: Icon(Icons.send),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
