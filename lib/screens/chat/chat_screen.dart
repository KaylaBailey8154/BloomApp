

import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;


class ChatScreen extends StatefulWidget {


  final CartItem cartItem;
  final String otherParty;
  ChatScreen({this.cartItem, this.otherParty});


  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  DatabaseService databaseService = new DatabaseService();
  final messageTextController = TextEditingController();
  final AuthService _auth = AuthService();
  String messageText;




  @override
  /*void initState() {
    getCurrentUser();
    super.initState();
  }*/

  /*void getCurrentUser() async {
    try {
      final user = await _auth.user;
      if (user != null) {
        loggedInUser = User as FirebaseUser;
      }
    }catch (e){
      print (e);
    }
  }*/
  /* void getMessages() async {
    final messages = await _firestore.collection('messages').getDocuments();
    for (var messages in messages.documents) {
      print(messages.data);
    }
  }*/

  // listening to changes like any new messages through data snapshots
  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var messages in snapshot.documents) {
        print(messages.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              messagesStream();
            },
          ),
        ],
        title: Text('Bloom Chat'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(otherParty:
            //user.uid!= widget.cartItem.buyerUID ? widget.cartItem.buyerUID : widget.cartItem.supplierUID
             widget.otherParty ,),
            // the async snap shot contains a query snapshot from firebase we access the query snapshot through the data
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {

                        messageText = value;
                      },


                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();

                      _firestore.collection('chatMessages').document(DateTime.now().toIso8601String())

                          .setData({
                        'text': messageText,
                        'senderUid': user.uid,
                        'receiverUid': widget.otherParty,//user.uid!= widget.cartItem.buyerUID ? widget.cartItem.buyerUID : widget.cartItem.supplierUID,
                        //'senderRole': user.uid== widget.cartItem.buyerUID? 'buyer':'supplier',
                      });
                      


                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //searchList()
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
 final String otherParty;
  MessagesStream({this.otherParty});
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('chatMessages') //.where('senderUID', isEqualTo: user.uid )
          .snapshots(),
      // when there is new data it should rebuild
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center (
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightGreenAccent,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed; //dynamic data type
        List <MessageBubble> messageBubbles = [];
        for (var message in messages) {
if((message.data['senderUid'] == user.uid || message.data['senderUid'] == otherParty) &&(message.data['receiverUid'] == user.uid || message.data['receiverUid'] == otherParty)){
          final messageText = message.data ['text'];
          final messageSender = message.data['senderUid'];
          final messageReceiver = message.data['receiverUid'];
          final currentUser = user.uid;

          final messageBubble = MessageBubble (
            sender: messageSender,
            receiver: messageReceiver,
            text:messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);

        }}


        return Expanded(
          child: ListView (
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );


      },
    );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble ({this.sender, this.text, this.isMe, this.receiver});

  final String sender;
  final String text;
  final bool isMe;
  final String receiver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column (
        crossAxisAlignment:
        isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,
            style: TextStyle (
              fontSize: 12,
              color: Colors.black54,

            ),
          ),
          Material(
            borderRadius: isMe ?
            BorderRadius.only(topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30), topRight: Radius.circular(30),
            ),
            elevation: 5.0,
            color:  isMe ? Colors.lightGreen : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text ,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ?Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}



