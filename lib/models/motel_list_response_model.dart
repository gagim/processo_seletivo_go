import 'package:processo_seletivo_go/models/data_model.dart';

class MotelListResponseModel {
  bool? sucesso;
  DataModel? data;
  List<dynamic>? mensagem;

  MotelListResponseModel({this.sucesso, this.data, this.mensagem});

  Map<String, dynamic> toMap() {
    return {'sucesso': sucesso, 'data': data, 'mensagem': mensagem};
  }

  MotelListResponseModel.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'];
    //mensagem = json['mensagem'];

    if (json['data'] != null) {
      data = DataModel.fromJson(json['data']);
    }
  }
}
