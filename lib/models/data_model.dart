import 'package:processo_seletivo_go/models/motel_model.dart';

class DataModel {
  int? pagina;
  int? qtdPorPagina;
  int? totalSuites;
  int? totalMoteis;
  int? raio;
  double? maxPaginas;
  List<MotelModel>? moteis;

  DataModel(
      {this.pagina,
      this.qtdPorPagina,
      this.totalSuites,
      this.totalMoteis,
      this.raio,
      this.maxPaginas,
      this.moteis});

  Map<String, dynamic> toMap() {
    return {
      'pagina': pagina,
      'qtdPorPagina': qtdPorPagina,
      'totalSuites': totalSuites,
      'totalMoteis': totalMoteis,
      'raio': raio,
      'maxPaginas': maxPaginas,
      'moteis': moteis
    };
  }

  DataModel.fromJson(Map<String, dynamic> json) {
    pagina = json['pagina'];
    qtdPorPagina = json['qtdPorPagina'];
    totalSuites = json['totalSuites'];
    totalMoteis = json['totalMoteis'];
    raio = json['raio'];
    maxPaginas = json['maxPaginas'];
    moteis = motelList(json);
  }

  List<MotelModel>? motelList(Map<String, dynamic> json) {
    return json['moteis']
        ?.map<MotelModel>((json) => MotelModel.fromJson(json))
        .toList();
  }
}
