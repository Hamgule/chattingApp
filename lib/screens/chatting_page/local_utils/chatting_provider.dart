import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/chatting_model.dart';
import 'package:flutter/cupertino.dart';

class ChattingProvider extends ChangeNotifier {

  final String roomId;
  final String name;

  ChattingProvider(this.roomId, this.name);

  List<ChattingModel> chattingList = [];

  Stream<QuerySnapshot> getSnapShot() {
    final f = FirebaseFirestore.instance;

    return f.collection('rooms')
        .doc(roomId)
        .collection('chattings')
        .limit(1)
        .orderBy('uploadTime', descending: true)
        .snapshots();
  }

  void addOne(ChattingModel model) {
    chattingList.insert(0, model);
    notifyListeners();
  }

  Future load() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;

    var result = await f.collection('rooms')
        .doc(roomId)
        .collection('chattings')
        // .where('uploadTime', isGreaterThan: now)
        .orderBy('uploadTime', descending: true)
        .get();

    var l = result.docs.map((e) => ChattingModel.fromJson(e.data())).toList();
    chattingList.addAll(l);
    notifyListeners();
  }

  Future send(String text) async {
    Timestamp now = Timestamp.now();
    final f = FirebaseFirestore.instance;

    await f.collection('rooms')
        .doc(roomId)
        .collection('chattings')
        // .doc(now.toString())
        .add(ChattingModel(name, text, now)
        .toJson()
    );
  }
}