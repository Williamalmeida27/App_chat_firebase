import 'package:appfirebase/models/chat_model.dart';
import 'package:appfirebase/pages/chat/chat_page.dart';
import 'package:appfirebase/services/db_firestore.dart';
import 'package:appfirebase/shared/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nomeSala = '';
  bool dark_mode = false;
  final remoteConfig = FirebaseRemoteConfig.instance;
  TextEditingController nickNameController = TextEditingController();
  TextEditingController nomeSalaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final db = DbFirestore().db.collection('chats');
    return SafeArea(
      child: Scaffold(
        backgroundColor: dark_mode ? Colors.black : Colors.white,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          // backgroundColor: dark_mode ? Colors.black : Colors.deepPurple,
          actions: [
            IconButton(
                onPressed: () async {
                  if (remoteConfig.getBool("modo_dark_enable")) {
                    await remoteConfig.setDefaults({"modo_dark_enable": false});
                  } else {
                    await remoteConfig.setDefaults({"modo_dark_enable": true});
                  }
                  setState(() {
                    dark_mode = remoteConfig.getBool("modo_dark_enable");
                  });
                },
                icon: Icon(
                  Icons.dark_mode,
                  color: dark_mode ? Colors.white : Colors.black,
                ))
          ],
          title: const Text("App Firebase"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: db.snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data!.docs.map((e) {
                            var salas = ChatModel.fromSalaJson(
                                (e.data() as Map<String, dynamic>));
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      nomeSala = salas.nomeSala;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ChatPage(
                                                nickname:
                                                    nickNameController.text,
                                                nomeSala: salas.nomeSala)));
                                  },
                                  child: Text(salas.nomeSala)),
                            );
                          }).toList());
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                              label: Text("Informe seu nick name:")),
                          controller: nickNameController,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              label: Text("Informe uma nova sala:")),
                          controller: nomeSalaController,
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            // DocumentReference chatsSalas = DbFirestore()
                            //     .db
                            //     .collection('chats')
                            //     .doc(nomeSalaController.text);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatPage(
                                        nickname: nickNameController.text,
                                        nomeSala: nomeSalaController.text)));
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String userId =
                                prefs.getString('user_id').toString();
                            var nomeSalas = DbFirestore()
                                .db
                                .collection('chats')
                                .doc(nomeSalaController.text);

                            var salas = ChatModel.sala(
                                nomeSala: nomeSalaController.text,
                                userId: userId);

                            await nomeSalas.set(salas.toSalaJson());
                          },
                          child: const Text("Entrar"))
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
