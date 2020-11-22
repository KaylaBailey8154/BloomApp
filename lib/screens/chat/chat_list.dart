
import 'package:bloomflutterapp/models/buyer.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_tile.dart';
import 'package:bloomflutterapp/screens/chat/chat_screen.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<MessageBubble>>(context) ?? [];
    final user = Provider.of<User>(context);

    List<String> buyerUids = [];
    for (var message in messages) {
      buyerUids.add(message.sender);
    }
    List<String> distinctBuyerUids = buyerUids.toSet().toList();

    List<String> buyerMessages = [];
    for (String uid in distinctBuyerUids) {
      buyerMessages.add(messages
          .where((MessageBubble m) {
            return m.sender == uid;
          })
          .last
          .text
          .toString());
    }

    return StreamProvider<List<Buyer>>.value(
      value: DatabaseService(uid: user.uid).buyers,
      child: ChatListSecondLevel(
        uids: distinctBuyerUids,
        lastMessages: buyerMessages,
      ),
    );
  }
}

class ChatListSecondLevel extends StatefulWidget {
  final List<String> uids;
  final List<String> lastMessages;
  ChatListSecondLevel({this.uids, this.lastMessages});
  @override
  _ChatListSecondLevelState createState() => _ChatListSecondLevelState();
}

class _ChatListSecondLevelState extends State<ChatListSecondLevel> {
  @override
  Widget build(BuildContext context) {
    final buyers = Provider.of<List<Buyer>>(context) ?? [];
    List<Buyer> filteredBuyers = [];
    for (var uid in widget.uids) {
      filteredBuyers.add(buyers.where((Buyer b) {
        return b.uid == uid;
      }).first);
    }
    print(filteredBuyers.length);

    List<String> filteredMessages;

    return ListView.builder(
      itemCount: filteredBuyers.length,
      itemBuilder: (context, index) {
        return BuyerTile(
                buyer: filteredBuyers[index],
                message: widget.lastMessages[index])
            //Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductDetails())))
            ;
      },
    );
  }
}
