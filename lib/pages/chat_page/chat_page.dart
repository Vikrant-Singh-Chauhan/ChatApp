import 'package:chat_app/sevices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../sevices/share_prefer.dart';

class ChatPage extends StatefulWidget {
  String ? name,profileUrl,username;
  ChatPage({this.name,this.profileUrl,required this.username, required String chatRoomId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? myUserName , myName , myEmail , myPicture , chatRoom,messageId;
  TextEditingController messageController = TextEditingController();

  getTheSharedprefer() async{
    myUserName = await SharePreferHelper().getUserDisplayName();
    myName = await SharePreferHelper().getUserDisplayName();
    myEmail = await SharePreferHelper().getUserEmail();
    myPicture = await SharePreferHelper().getUserImage();
    chatRoom = await getChatRoomIdByUsername(widget.username!,myUserName!);
    setState(() {
    });
  }

  @override
  void initState() {
    getTheSharedprefer();
    super.initState();
  }

  getChatRoomIdByUsername(String a , String b){
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$a\$b";
    }else{
      return "$b\$a";
    }
  }
  addMessage(bool sentClicked){
    if (messageController.text! == ""){
      String message = messageController.text;
      messageController.text="";
      DateTime now = DateTime.now();
      String formatedDate = DateFormat("h:mma").format(now);
      Map<String, dynamic>massageInfoMap =  {
        "message":message,
        "sentBy":myUserName,
        "ts": FieldValue.serverTimestamp(),
        "imagaurl":myPicture
      };
      messageId = randomAlphaNumeric(10);
      DatabaseMethod().addMassage(chatRoom!, messageId!, massageInfoMap).then((value) async {
        Map<String,dynamic>lastMassageInfoMap = {
          "lastMassage":message,
          "lastMessageSentTs":formatedDate,
          "time":FieldValue.serverTimestamp(),
          "lastMassageSentBy":myUserName
        };
        await DatabaseMethod().updateLastMessageSend(chatRoom!, lastMassageInfoMap);
        if(sentClicked){
          message = "";
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vikrant Singh",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[100],
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    ///  other massage //////
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )),
                      child: Text(
                        "Hello, How are you ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                ///  my massage
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )),
                      child: Text(
                        "Hello, How are you ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.43,),                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red[100],
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.mic_none,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[50],                          ),
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: "Write a massage...",
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.attach_file_rounded)
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red[100],
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.send_rounded)
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
