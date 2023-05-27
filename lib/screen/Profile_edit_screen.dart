import 'package:flutter/material.dart';
import 'package:learnable/const/text_style.dart';
import '../const/colors.dart';
import 'dart:convert';
import 'package:learnable/screen/user_screen.dart';
import 'package:learnable/screen/main_screen.dart';
import 'package:http/http.dart' as http;

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String text = '';
  int selectedImageIndex = 0;

  List<String> imageList = [
    'assets/images/fox.png',
    'assets/images/dog.png',
    'assets/images/cat.png',
    'assets/images/robot.png',
    'assets/images/boiled_egg.png',
    'assets/images/fried_egg.png'
  ];

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
              "프로필 수정",
              style: MyTextStyle.CbS23W700,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: MyColors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  imageList[selectedImageIndex],
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    icon: Icon(
                      Icons.change_circle,
                      color: Color(0xFF7AC38F),
                      size: 30,
                    ),
                    onPressed: () {
                      // Show image slider
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 150,
                              width: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = index;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        child: Image.asset(
                                          imageList[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "러너블",
                counterText: "${text.length}/10",
              ),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            SizedBox(height: 100),
            Container(
              height: 50,
              width: double.infinity, // Matches the width of the input field
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF7AC38F)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text(
                  "완료",
                  style: MyTextStyle.CwS20W700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
