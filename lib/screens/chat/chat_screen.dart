

import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/offer.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/chat/Profile_details.dart';
import 'package:bloomflutterapp/screens/chat/cartItem_details.dart';
import 'package:flutter/material.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;


class ChatScreen extends StatefulWidget {


  final CartItem cartItem;
  final String otherUid;
  ChatScreen({this.cartItem, this.otherUid});


  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  DatabaseService databaseService = new DatabaseService();
  final messageTextController = TextEditingController();
  final AuthService _auth = AuthService();
  String messageText;

  String price = '0';
  double _currentSliderValue = 0;






  Future<UserData> otherUser (String otherParty) async{
    var otherUser = await Firestore.instance.collection('users').document(otherParty).get();
    return DatabaseService().otherUserDataFromSnapshot(otherUser);
  }


  
  Future<CartItem> theItemInQuestion (String theirRole, String myUid, String theirUid) async {
     QuerySnapshot query = await Firestore.instance.collection('cartItems').getDocuments();

    List<CartItem> allCartItems = DatabaseService().cartItemListFromSnapshot(query);

    if(theirRole == 'buyer'){


     CartItem filteredItems = allCartItems.where((CartItem c) {
         return  c.buyerUID == theirUid && c.supplierUID == myUid;
      }).last;
        return filteredItems;
    }
      else if(theirRole== 'supplier'){

      CartItem filteredItems =  allCartItems.where((CartItem c) {
         return  c.supplierUID == theirUid && c.buyerUID == myUid;
      }).last;
      return filteredItems;
    }
return null;

  }


    @override
  Widget build(BuildContext context) {

    double totalAmount = _currentSliderValue * double.parse(price);
      String total = totalAmount.toString();


    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          FlatButton.icon(
            onPressed : () async {
          UserData youser = await otherUser(widget.otherUid);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileDetails(userData: youser,)),
          );},
            icon: Icon(Icons.account_circle),
            label: Text ('Profile'),
          ),
          FlatButton.icon(
            onPressed: () async{
              UserData youser = await otherUser(widget.otherUid);
              CartItem theItem = await theItemInQuestion(youser.role, user.uid, youser.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartItemDetails(stock: theItem,)),
              );
          },
            icon: Icon(Icons.info),
            label: Text ('Item'),
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
             widget.otherUid ,),

            StreamBuilder<Offer>(stream: DatabaseService(uid: user.uid).offer,
                builder: (context, snapshot){
              if(snapshot.hasData){

                return Row(
                  children: [
                    FlatButton(
                      onPressed: () {
                        _firestore.collection('chatMessages').document(DateTime.now().toIso8601String())
                            .setData({
                          'text': 'I am happy to accept that offer. You should receive an invoice by email shortly.',
                          'senderUid': user.uid,
                          'receiverUid': widget.otherUid,
                        });

                        _firestore.collection('transactions').document()
                            .setData({
                          'buyerUid': snapshot.data.senderUid,
                          'receiverUid': snapshot.data.receiverUid,
                          'stemLength': snapshot.data.quantity,
                          'companyName': snapshot.data.companyName,
                          'datePicked':snapshot.data.datePicked,
                          'photoUrl': snapshot.data.photoUrl,
                          'flowerColour':snapshot.data.flowerColour,
                          'flowerType':snapshot.data.flowerType,
                          'quantity': snapshot.data.quantity,
                          'price': snapshot.data.price,
                          'totalPrice': snapshot.data.totalPrice,
                        });
                         Firestore.instance
                            .collection('offers')
                         .document(user.uid).delete();
                                                                       },
                      color: Colors.green,
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _firestore.collection('chatMessages').document(DateTime.now().toIso8601String())
                            .setData({
                          'text': 'Unfortunately I cannot accept that offer. Please send an improved offer and I will consider it!',
                          'senderUid': user.uid,
                          'receiverUid': widget.otherUid,
                        });
                        Firestore.instance
                            .collection('offers')
                            .document(user.uid).delete();

                      },
                      color: Colors.red,
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                );
              }
              else {
               print('no snapshot');
               return Container();
              }
            }),
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
                        'receiverUid': widget.otherUid,
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

                    StreamBuilder<UserData>(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                        if(snapshot.data.role == 'buyer'){
                        return RaisedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)),
                                isScrollControlled:true,
                                context: context,
                                builder: (BuildContext bc) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 400,
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Make an Offer:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Text(
                                                'Quantity:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Slider(
                                                    value: _currentSliderValue,
                                                    min: 0,
                                                    max: widget.cartItem.quantity.toDouble(),
                                                    divisions: 10,
                                                    activeColor: Colors.green,
                                                    inactiveColor: Colors
                                                        .lightGreen,
                                                    label: _currentSliderValue
                                                        .round().toString(),
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _currentSliderValue = val;
                                                          total = ( _currentSliderValue  * double.parse(price)).toInt().toString();
                                                          print(total);
                                                        });
                                                      }

                                                  );
                                                }
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'Price per stem:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: TextFormField(
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      labelText: 'R',
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(25),
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 2),
                                                      ),
                                                    ),
                                                    validator: (val) =>
                                                    val.isEmpty ? 'R' : null,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        price = val;
                                                        total = ( _currentSliderValue  * double.parse(price)).toInt().toString();
                                                        print(total);
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                'Total Amount: R$total',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 20,),

                                              /*SizedBox(
                                                height: 50,
                                                width: 100,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'Total Amount',
                                                  ),
                                                  initialValue: total,
                                                  validator: (val) =>
                                                  val.isEmpty
                                                      ? 'Please Enter a Company Name'
                                                      : null,
                                                  onChanged: (total) =>
                                                      setState(() =>
                                                          total=total
                                                     // total = ( _currentSliderValue  * double.parse(price)).toInt().toString()
                                                      ),
                                                  // decoration: textInputDecoration,
                                                ),
                                              ),*/
                                            ],
                                          ),
                                          SizedBox(height: 50,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              FlatButton(
                                                  color: Colors.green,
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  }
                                              ),
                                              SizedBox(width: 10,),
                                              FlatButton(
                                                  color: Colors.green,
                                                  child: Text(
                                                    'Offer',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    int quant = _currentSliderValue.toInt();
                                                    double doublePrice = double.parse(price);

                                                    _firestore.collection('chatMessages').document(DateTime.now().toIso8601String())
                                                        .setData({
                                                      'text': 'I would like to offer you R$price per stem for $quant stems. The total price for this is R$total',
                                                      'senderUid': user.uid,
                                                      'receiverUid': widget.otherUid,});

                                                    _firestore.collection('offers').document(widget.otherUid)
                                                        .setData({
                                                      'senderUid': user.uid,
                                                      'receiverUid': widget.otherUid,
                                                      'stemLength': widget.cartItem.stemLength,
                                                      'companyName':widget.cartItem.companyName,
                                                      'datePicked':widget.cartItem.datePicked,
                                                      'photoUrl':widget.cartItem.photoUrl,
                                                      'flowerColour':widget.cartItem.flowerColour,
                                                      'flowerType':widget.cartItem.flowerType,
                                                      'quantity': _currentSliderValue,
                                                      'price': doublePrice,
                                                      'totalPrice': _currentSliderValue  * double.parse(price),
                                                    });
                                                    print('fired');
                                                    Navigator.pop(context);
                                                  }
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }

                            );
                            messageTextController.clear();
                          },
                          color: Colors.lightGreen,
                          child: Text(
                            'Offer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        );}}
                        return Container();
                      }
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
  final String otherParty;
  MessagesStream({this.otherParty});
  @override

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



