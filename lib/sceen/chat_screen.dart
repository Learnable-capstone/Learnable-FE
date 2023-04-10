import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("챗봇"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: _messages[index],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "메시지를 입력하세요",
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _handleSubmitted(_textController.text);
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "사용자",
      isUser: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    // 챗봇 API 호출 및 응답 처리
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.name,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            child: Text(name[0]),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}