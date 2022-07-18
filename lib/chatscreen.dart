// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_bot/Widgets/custom_tile.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String send ="";
  TextEditingController textFieldController = TextEditingController();
  bool isWriting = false ;
  List<Message> messages = [
    Message(text: 'hello', isSentByMe: false)
  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.adb_rounded,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: messageList()
          ),
          chatControls(),
        ],
      ),
    );
  }
  Widget messageList(){
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),// use strambuilder later
        itemCount: messages.length,
        itemBuilder: (context,index){
          return chatMessageItem(messages[index]) ;
        }
    ) ;
  }
  Widget chatMessageItem(Message newText){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: newText.isSentByMe? senderLayout(newText.text):receiverLayout(newText.text),
      ),
    );
  }

  Widget senderLayout(String chat){
    Radius messageRadius = Radius.circular(10);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: messageRadius,
                topRight: messageRadius,
                bottomLeft: messageRadius,
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("$chat",style: TextStyle(color: Colors.white,fontSize:16 ),),
          ),
        ),
      ],
    );
  }

  Widget receiverLayout(String chat){
    Radius messageRadius = Radius.circular(10);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.65
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: messageRadius,
                topRight: messageRadius,
                bottomLeft: messageRadius,
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("$chat",style: TextStyle(color: Colors.white,fontSize:16 ),),
          ),
        ),
      ],
    );
  }

  Future getChatbotReply(String userReply) async {
    var response = await http.get(Uri.parse("http://api.brainshop.ai/get?bid=167106&key=iABJFJf8sP50MTTg&uid='Atul'&msg=${userReply}"));
    var data = jsonDecode(response.body);
    final botreply =  Message(
        text: data["cnt"],
        isSentByMe: false
    );
    setState(() {
      messages.add(botreply);
    });
  }






  Widget chatControls(){
    setWritingTo(bool val){
      isWriting = val ;
    }


    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          SizedBox(width: 5,),
          Expanded(
              child:TextField(
                controller: textFieldController,
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: (val){
                  (val.isNotEmpty&&val.trim()!="") ? setWritingTo(true) : setWritingTo(false);
                  send = val;
                },
                decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                      borderSide : BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    filled: true ,
                    fillColor: CupertinoColors.separator,
                    suffixIcon: GestureDetector(
                      onTap: (){},
                      child: Icon(Icons.face,color: Colors.white,) ,
                    )
                ),
              ) ),
          isWriting ? Container(): Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.record_voice_over,color: Colors.white,),
          ),
          isWriting? Container():Icon(Icons.camera_alt,color: Colors.white,),
          isWriting ? Container(margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.red,
                    Colors.blue ,
                  ]
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                size: 15,
              ),
              onPressed: (){
                final message =  Message(
                    text: send,
                    isSentByMe: true
                );
                setState(() {
                  messages.add(message);
                  textFieldController.clear();
                });
                getChatbotReply(send);
              },
            ),
          ) : Container(),
        ],
      ),
    );
  }
}





