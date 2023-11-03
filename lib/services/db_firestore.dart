import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirestore {
  var _db = FirebaseFirestore.instance;

  FirebaseFirestore get db => _db;

  DbFirestore();

  instancia(String colecao) {
    db.collection(colecao);
  }
}
