import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  DateTime dataHora = DateTime.now();
  String nomeSala = "";
  String nickName = "";
  String text = "";
  String userId = "";

  ChatModel.sala({required this.nomeSala, required this.userId});

  ChatModel(
      {required this.nomeSala,
      required this.nickName,
      required this.text,
      required this.userId});

  ChatModel.fromJson(Map<String, dynamic> json) {
    dataHora = (json['data_hora'] as Timestamp).toDate();
    nomeSala = json['nomeSala'];
    nickName = json['nickName'];
    text = json['text'];
    userId = json['userId'];
  }

  ChatModel.fromSalaJson(Map<String, dynamic> json) {
    nomeSala = json['nomeSala'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_hora'] = Timestamp.fromDate(this.dataHora);
    data['nomeSala'] = this.nomeSala;
    data['nickName'] = this.nickName;
    data['text'] = this.text;
    data['userId'] = this.userId;
    return data;
  }

  Map<String, dynamic> toSalaJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeSala'] = this.nomeSala;
    data['userId'] = this.userId;
    return data;
  }
}
