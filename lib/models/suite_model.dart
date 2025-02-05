import 'package:processo_seletivo_go/models/item_category_model.dart';
import 'package:processo_seletivo_go/models/item_model.dart';
import 'package:processo_seletivo_go/models/period_model.dart';

class SuiteModel {
  String? nome;
  int? qtd;
  bool? exibirQtdDisponiveis;
  List<String>? fotos;
  List<ItemModel>? itens;
  List<ItemCategoryModel>? categoriaItens;
  List<PeriodModel>? periodos;

  SuiteModel(
      {this.nome,
      this.qtd,
      this.exibirQtdDisponiveis,
      this.fotos,
      this.itens,
      this.categoriaItens,
      this.periodos});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'qtd': qtd,
      'exibirQtdDisponiveis': exibirQtdDisponiveis,
      'fotos': fotos,
      'itens': itens,
      'categoriaItens': categoriaItens,
      'periodos': periodos
    };
  }

  SuiteModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    qtd = json['qtd'];
    exibirQtdDisponiveis = json['exibirQtdDisponiveis'];
    fotos = json['fotos'];
    itens = json['itens'];
    categoriaItens = json['categoriaItens'];
    periodos = json['periodos'];
  }
}
