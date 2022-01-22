import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingModel {
  final String name;
  final String text;
  final Timestamp uploadTime;

  ChattingModel(this.name, this.text, this.uploadTime);

  factory ChattingModel.fromJson(Map<String, dynamic> json)
    => ChattingModel(json['name'], json['text'], json['uploadTime']);


  Map<String, dynamic> toJson() => <String, dynamic> {
    'name': name,
    'text': text,
    'uploadTime': uploadTime,
  };
}