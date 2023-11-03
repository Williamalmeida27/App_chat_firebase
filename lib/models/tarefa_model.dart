import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaModel {
  String descricao = '';
  bool concluido = false;
  DateTime dataCriacao = DateTime.now();
  DateTime dataAlteracao = DateTime.now();
  String userId = '';

  TarefaModel(this.descricao, this.concluido, this.userId);

  TarefaModel.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
    dataCriacao = (json['dataCriacao'] as Timestamp).toDate();
    dataAlteracao = (json['dataAlteracao'] as Timestamp).toDate();
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['dataCriacao'] = Timestamp.fromDate(dataCriacao);
    data['dataAlteracao'] = Timestamp.fromDate(dataAlteracao);
    data['userId'] = userId;
    return data;
  }
}
