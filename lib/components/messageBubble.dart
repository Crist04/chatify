import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BubbleComponent extends StatelessWidget {
  BubbleComponent({super.key, required this.sender, required this.text,required this.isme});
  final String sender;
  final String text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Material(
              borderRadius: isme?BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ):BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              elevation: 5.0,
              color: isme?Colors.lightBlueAccent:Colors.blueAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(color:Colors.white, fontSize: 15.0),
                ),
              )),
        ],
      ),
    );
  }
}
