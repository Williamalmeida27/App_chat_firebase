import 'package:appfirebase/pages/chat/screen/screen_page.dart';
import 'package:appfirebase/pages/tarefas/tarefas_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Tarefas"),
            leading: Icon(Icons.task),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TarefasPage()));
            },
          ),
          ListTile(
            title: Text("inicial"),
            leading: Icon(Icons.house),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScreenPage()));
            },
          )
        ],
      ),
    );
  }
}
