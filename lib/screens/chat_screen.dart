import 'package:chatify/components/messageBubble.dart';
import 'package:chatify/constants.dart';
import 'package:chatify/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
final messageTextController =TextEditingController();
  
  late String messageText;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages()async {
  //   final messages= await _firestore.collection('messages').get();
  //   for(var msg in messages.docs)
  //   {
  //     print(msg.data());
  //   }
  // }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var messages in snapshot.docs) {
        print(messages.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            messageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender': loggedInUser.email,
                          'text': messageText,
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messageStream extends StatelessWidget {
  const messageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs;
          List<BubbleComponent> messagesWidgets = [];
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser =loggedInUser.email;
              if(currentUser == messageSender)
              {
                //TODO
              }
            
            final messageWidget =
                BubbleComponent(sender: messageSender, text: messageText,isme: currentUser == messageSender);

            messagesWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              children: messagesWidgets,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
