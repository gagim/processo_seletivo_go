import 'package:processo_seletivo_go/models/suite_model.dart';

class MotelModel {
  String? fantasia;
  String? logo;
  String? bairro;
  double? distancia;
  int? qtdFavoritos;
  List<SuiteModel>? suites;
  int? qtdAvaliacoes;
  double? media;

  MotelModel(
      {this.fantasia,
      this.logo,
      this.bairro,
      this.distancia,
      this.qtdFavoritos,
      this.suites,
      this.qtdAvaliacoes,
      this.media});

  Map<String, dynamic> toMap() {
    return {
      'fantasia': fantasia,
      'logo': logo,
      'bairro': bairro,
      'distancia': distancia,
      'qtdFavoritos': qtdFavoritos,
      'suites': suites,
      'qtdAvaliacoes': qtdAvaliacoes,
      'media': media
    };
  }

  MotelModel.fromJson(Map<String, dynamic> json) {
    fantasia = json['fantasia'];
    logo = json['logo'];
    bairro = json['bairro'];
    distancia = json['distancia'];
    qtdFavoritos = json['qtdFavoritos'];
    suites = json['suites'];
    qtdAvaliacoes = json['qtdAvaliacoes'];
    media = json['media'];
  }
}
