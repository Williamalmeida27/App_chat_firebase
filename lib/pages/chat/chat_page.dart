import 'package:appfirebase/models/chat_model.dart';
import 'package:appfirebase/services/db_firestore.dart';
import 'package:appfirebase/shared/widgets/chat_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String nomeSala;
  final String nickname;
  const ChatPage({super.key, required this.nickname, required this.nomeSala});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = TextEditingController();
  late ChatModel chats;
  String nomeSala = '';
  String nomePessoa = '';
  var userId;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    nomeSala = widget.nomeSala;
    nomePessoa = widget.nickname;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    var db = DbFirestore().db.collection('chats');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.nomeSala),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: db.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot == null) {
                      return const CircularProgressIndicator();
                    }
                    return ListView(
                        children: snapshot.data!.docs.map((e) {
                      var chat = ChatModel.fromJson(
                          (e.data() as Map<String, dynamic>));
                      return ChatWidgets(
                        chatModel: chat,
                        myMenssage: chat.userId == userId,
                        sala: chat.nomeSala == nomeSala,
                      );
                    }).toList());
                  }),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: TextField(
                    controller: textEditingController,
                  )),
                  IconButton(
                      onPressed: () async {
                        // var chatsSalas = DbFirestore()
                        //     .db
                        //     .collection('chats')
                        //     .doc(widget.nomeSala);
                        // chats = ChatModel(
                        //     nickName: nomePessoa,
                        //     text: textEditingController.text,
                        //     userId: userId,
                        //     nomeSala: nomeSala);

                        // await chatsSalas.set(chats.toJson());

                        // await db.add(chats.toJson());
                        textEditingController.text = '';
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
