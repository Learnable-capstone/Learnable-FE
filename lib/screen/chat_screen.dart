import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import '../const/colors.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String title;
  final String subjectId;

  const ChatScreen({Key? key, required this.title, required this.subjectId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBotMessage();
  }

  Future<void> _fetchBotMessage() async {
    try {
      final subjectIdInt = int.parse(widget.subjectId);

      final response = await http.get(
        Uri.parse(
            'http://43.201.186.151:8080/botmessages/1/questions/${subjectIdInt + 1}'),
      );

      if (response.statusCode == 200) {
        var botMessage = utf8.decode(response.bodyBytes);
        setState(() {
          _messages.add({'type': 'bot', 'text': botMessage});
        });
      } else {
        setState(() {
          _messages.add({
            'type': 'bot',
            'text': 'Error occurred while fetching the bot message.'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'type': 'bot',
          'text': 'Error occurred while fetching the bot message.'
        });
      });
    }
  }

  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add({'type': 'user', 'text': text});
    });
    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse('http://43.201.186.151:8080/usermessages/chat?chatroomId=1'),
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
        });
      } else {
        setState(() {
          _messages.add({
            'type': 'bot',
            'text': 'Error occurred while sending the message.'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'type': 'bot',
          'text': 'Error occurred while sending the message.'
        });
      });
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isUserMessage = message['type'] == 'user';
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isUserMessage ? Colors.blue : Colors.grey[300],
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        child: Text(
          message['text'],
          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
        ),
      ),
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
            title: Column(children: [
              Image.asset(
                "assets/images/tag" + widget.subjectId + ".png",
                width: 100,
              ),
              Text(
                widget.title,
                style: MyTextStyle.CbS23W700,
              ),
            ]),
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
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages.map(_buildMessage).toList(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            margin: EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: '답변을 입력하세요.'),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _sendMessage(value);
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
