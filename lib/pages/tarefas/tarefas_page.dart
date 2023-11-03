import 'package:appfirebase/models/tarefa_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final db = FirebaseFirestore.instance;
  TextEditingController descricaoController = TextEditingController();
  bool naoConcluidas = false;
  String userId = '';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = (prefs.getString('user_id'))!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarefas"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              descricaoController.text = "";
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      child: AlertDialog(
                        title: const Text("Adicionar Tarefa"),
                        content: TextField(
                          controller: descricaoController,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () async {
                              var tarefas = TarefaModel(
                                  descricaoController.text, false, userId);

                              await db
                                  .collection("tarefas")
                                  .add(tarefas.toJson());

                              Navigator.pop(context);
                            },
                            child: const Text("Salvar"),
                          )
                        ],
                      ),
                    );
                  });
            }),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filtrar não conluídos"),
                  Switch(
                      value: naoConcluidas,
                      onChanged: (value) {
                        setState(() {
                          naoConcluidas = value;
                        });
                      })
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: naoConcluidas
                        ? db
                            .collection("tarefas")
                            .where("userId", isEqualTo: userId)
                            .where("concluido", isEqualTo: false)
                            .snapshots()
                        : db
                            .collection("tarefas")
                            .where("userId", isEqualTo: userId)
                            .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const Center(child: CircularProgressIndicator())
                          : ListView(
                              children: snapshot.data!.docs.map((e) {
                              var tarefa = TarefaModel.fromJson(
                                  (e.data() as Map<String, dynamic>));

                              return Dismissible(
                                key: Key(e.id),
                                onDismissed:
                                    (DismissDirection dismissDirection) async {
                                  await db
                                      .collection("tarefas")
                                      .doc(e.id)
                                      .delete();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(tarefa.descricao),
                                    Switch(
                                        value: tarefa.concluido,
                                        onChanged: (value) async {
                                          tarefa.dataAlteracao = DateTime.now();
                                          tarefa.concluido = value;
                                          await db
                                              .collection("tarefas")
                                              .doc(e.id)
                                              .update(tarefa.toJson());
                                        })
                                  ],
                                ),
                              );
                            }).toList());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
