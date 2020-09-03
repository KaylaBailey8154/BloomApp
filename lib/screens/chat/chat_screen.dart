

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


  ChatScreen({this.cartItem});


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
            MessagesStream(),
            // the async snap shot contains a query snapshot from firebase we access the query snapshot thorugh the data t
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
                      //initiateSearch();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': user.uid,




                        // cartItem.buyerUID,
                      });
                      /*String getRecieverUid () {
                        if (user.uid == widget.cartItem.buyerUID) {
                          return widget.cartItem.supplierUID;
                        }
                        else {
                          return widget.cartItem.buyerUID;
                        }
                      }*/


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

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
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
          final messageText = message.data ['text'];
          final messageSender = message.data['sender'];
          final currentUser = user.uid;

          /*if (currentUser == messageSender) {

          }*/

          final messageBubble = MessageBubble (
            sender: messageSender,
            text:messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }


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

  MessageBubble ({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

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




/*
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseService databaseMethods = new DatabaseService();

  TextEditingController searchTextEditingController =
      new TextEditingController();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods.getUserByName(searchTextEditingController.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatRoomAndStartConversation(String fullName ){
    List <String> users = [fullName, ];
//databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.documents[index].data["fullName"],
                userNumber: searchSnapshot.documents[index].data["phoneNumber"],
              );
            })
        : Container();
  }

  // searchSnapshot !=null ?
  @override
  void initState() {
    super.initState();
  }

  final AuthService _auth = AuthService();

  FirebaseUser email;
  String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
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
                      onChanged: (value) {},
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Search Name and Surname',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      initiateSearch();
                    },
                    child: Text(
                      'Search',
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
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;

  final String userNumber;

  const SearchTile({this.userName, this.userNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                userNumber,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              child: Text("Message" ),
            ),
          )
        ],
      ),
    );
  }
}*/
