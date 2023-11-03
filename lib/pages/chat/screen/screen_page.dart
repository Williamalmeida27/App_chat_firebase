import 'package:appfirebase/models/chat_model.dart';
import 'package:appfirebase/services/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  var db = DbFirestore().db.collection('chats');

  // late ChatModel chats;
  var userId;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: db.snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const CircularProgressIndicator()
                : ListView(
                    children: snapshot.data!.docs.map((e) {
                      var conversas = ChatModel.fromJson(
                          (e.data() as Map<String, dynamic>));
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.amber,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(conversas.nickName),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(conversas.text)
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
          }),
    );
  }
}
