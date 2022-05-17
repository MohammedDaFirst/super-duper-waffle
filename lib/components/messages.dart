import 'package:flutter/material.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});
  final bool isMe;
  final text;
  final sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
              )),
          SizedBox(
            height: 5,
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5.0,
            color:
                isMe ? Color(0xff0088CC) : Color.fromARGB(255, 233, 230, 220),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('$text',
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: Center(
                  child: CircularProgressIndicator(
            backgroundColor: Color(0xff0088CC),
          )));
          //a loading animation from a package ^
        }
        List<MessageBubble> messageBubbles = [];
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: messageSender == loggedInUser.email,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
