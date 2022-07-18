// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:my_chat_bot/chatscreen.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatBot(),
  ));
}
class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80.0,),
            Text(
              'CHAT-BOT',
              style: TextStyle(
                color: Colors.purple[900],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/bot.jpg') ,
                  radius: 80.0,
                ),
              ],
            ),
            SizedBox(height: 80.0,),
            TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>ChatScreen()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purple.shade800
                ),
              ),
              child: Text('Start Chat',
                style: TextStyle(
                    color: Colors.grey
                ),),
            )
          ],
        ),
      ),
    );
  }
}
