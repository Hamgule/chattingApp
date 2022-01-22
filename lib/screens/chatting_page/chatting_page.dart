import 'dart:async';

import 'package:firebase_test/models/chatting_model.dart';
import 'package:firebase_test/screens/chatting_page/local_utils/chatting_provider.dart';
import 'package:firebase_test/screens/chatting_page/local_widgets/chatting_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late TextEditingController _controller;
  late StreamSubscription _streamSubscription;

  bool justEntered = true;

  @override
  void initState() {
    super.initState();
    var p = Provider.of<ChattingProvider>(context, listen: false,);

    _controller = TextEditingController();
    _streamSubscription = p.getSnapShot().listen((event) {
      if (justEntered) {
        justEntered = false; return;
      }
      p.addOne(ChattingModel.fromJson(
        event.docs[0].data() as Map<String, dynamic>)
      );

    });

    Future.microtask(
      () => p.load(),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var p = Provider.of<ChattingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.5),
        title: Text(
          '${p.roomId} - ${p.name}',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: p.chattingList.map(
                (e) => ChattingItem(chattingModel: e),
              ).toList(),
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: Colors.grey[300],
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .5,
            ),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5.0,
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                       fontSize: 25.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '텍스트 입력',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    String text = _controller.text;
                    _controller.text = '';
                    p.send(text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5.0,
                    ),
                    child: Icon(
                      Icons.send,
                      size: 33.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
