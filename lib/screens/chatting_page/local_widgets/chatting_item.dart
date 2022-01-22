import 'package:firebase_test/models/chatting_model.dart';
import 'package:firebase_test/screens/chatting_page/local_utils/chatting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChattingItem extends StatelessWidget {
  const ChattingItem({Key? key, required this.chattingModel}) : super(key: key);
  final ChattingModel chattingModel;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ChattingProvider>(context);
    var isMe = chattingModel.name == p.name;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0,),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0,),
                child: Text(
                  chattingModel.name,
                  style: const TextStyle(fontSize: 17.0,),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0,),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[isMe ? 700 : 800],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0),
                    bottomLeft: Radius.circular(isMe ? 30.0 : 0.0),
                    bottomRight: Radius.circular(isMe ? 0.0 : 30.0),
                  ),
                ),
                child: Text(
                  chattingModel.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
