import 'package:firebase_test/screens/chatting_page/chatting_page.dart';
import 'package:firebase_test/screens/chatting_page/local_utils/chatting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntrancePage extends StatefulWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {

  late TextEditingController _controllerRoomId;
  late TextEditingController _controllerName;

  @override
  void initState() {
    _controllerRoomId = TextEditingController();
    _controllerName = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerRoomId,
              style: const TextStyle(fontSize: 25.0,),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '방 아이디',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: _controllerName,
              style: const TextStyle(fontSize: 25.0,),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '이름 입력',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => ChattingProvider(
                        _controllerRoomId.text, _controllerName.text,
                      ),
                      child: const ChattingPage(),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  '방 입장하기',
                  style: TextStyle(fontSize: 25.0,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
