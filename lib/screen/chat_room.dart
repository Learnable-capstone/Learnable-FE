import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';

import '../const/colors.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("채팅방 추가",style: MyTextStyle.CbS30W500,),
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
          TextButton(onPressed: (){},
              child: Text("완료",style: MyTextStyle.CgS70W500,)
          )
        ],
      ),
    );
  }
}
