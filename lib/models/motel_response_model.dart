import 'package:processo_seletivo_go/models/data_model.dart';

class MotelResponseModel {
  bool? sucesso;
  DataModel? data;
  List<String>? mensagem;

  MotelResponseModel({this.sucesso, this.data, this.mensagem});

  Map<String, dynamic> toMap() {
    return {'sucesso': sucesso, 'data': data, 'mensagem': mensagem};
  }

  MotelResponseModel.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'];
    mensagem = List<String>.from(json['mensagem'] as List);

    if (json['data'] != null) {
      data = DataModel.fromJson(json['data']);
    }
  }
}
