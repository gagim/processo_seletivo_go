import 'package:processo_seletivo_go/models/discount_model.dart';

class PeriodModel {
  String? tempoFormatado;
  String? tempo;
  double? valor;
  double? valorTotal;
  bool? temCortesia;
  DiscountModel? desconto;

  PeriodModel(
      {this.tempoFormatado,
      this.tempo,
      this.valor,
      this.valorTotal,
      this.temCortesia,
      this.desconto});

  Map<String, dynamic> toMap() {
    return {
      'tempoFormatado': tempoFormatado,
      'tempo': tempo,
      'valor': valor,
      'valorTotal': valorTotal,
      'temCortesia': temCortesia,
      'desconto': desconto
    };
  }

  PeriodModel.fromJson(Map<String, dynamic> json) {
    tempoFormatado = json['tempoFormatado'];
    tempo = json['tempo'];
    valor = json['valor'];
    valorTotal = json['valorTotal'];
    temCortesia = json['temCortesia'];

    if (json['desconto'] != null) {
      desconto = json['desconto'];
    }
  }
}
