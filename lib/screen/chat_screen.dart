import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        Uri.parse('http://43.201.186.151:8080/api/v1/chat/test'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': text.toString(),
        }),
      );

      var answer = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        setState(() {
          _messages.add({
            'type': 'bot',
            'text': answer['choices'][0]['message']['content']
          });
        });
      } else {
        setState(() {
          _messages.add({'type': 'bot', 'text': 'Error occurred while sending the message.'});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'type': 'bot', 'text': 'Error occurred while sending the message.'});
      });
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isUserMessage = message['type'] == 'user';
    return Align(
      alignment:
      isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isUserMessage ? Colors.blue : Colors.grey[300],
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
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
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages.map(_buildMessage).toList(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type your message'),
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
