import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add('User: $text');
    });
    _controller.clear();

    try {
      // Replace with your REST API endpoint
      final response = await http.post(
          Uri.parse('http://43.201.186.151:8080/api/v1/chat'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'question': text.toString(),
          })
      );

      if (response.statusCode == 200) {
        setState(() {
          _messages.add('Bot: ${response.body}');
          print('${response.body}');
        });
      } else {
        setState(() {
          _messages.add('Bot: Error occurred while sending the message.');
        });
      }
    } catch (e) {
      setState(() {
        _messages.add('Bot: Error occurred while sending the message.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages
                    .map((message) => ListTile(title: Text(message)))
                    .toList(),
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
