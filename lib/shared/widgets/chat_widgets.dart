import 'package:appfirebase/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatWidgets extends StatelessWidget {
  final ChatModel chatModel;
  final bool myMenssage;
  final bool sala;
  const ChatWidgets(
      {super.key,
      required this.chatModel,
      required this.myMenssage,
      required this.sala});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: myMenssage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: myMenssage
                ? const Color.fromARGB(255, 139, 96, 213)
                : Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(8),
              bottomRight: const Radius.circular(8),
              topLeft: myMenssage ? const Radius.circular(8) : Radius.zero,
              topRight: myMenssage ? Radius.zero : const Radius.circular(8),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chatModel.text,
            ),
            Text("${chatModel.dataHora.hour}:${chatModel.dataHora.minute}"),
          ],
        ),
      ),
    );
  }
}
