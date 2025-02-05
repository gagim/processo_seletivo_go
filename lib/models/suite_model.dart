import 'package:processo_seletivo_go/models/item_category_model.dart';
import 'package:processo_seletivo_go/models/item_model.dart';
import 'package:processo_seletivo_go/models/period_model.dart';

class SuiteModel {
  String? nome;
  int? qtd;
  bool? exibirQtdDisponiveis;
  List<dynamic>? fotos;
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
    itens = itemList(json);
    categoriaItens = itemCategoryList(json);
    periodos = periodList(json);
  }

  List<ItemModel>? itemList(Map<String, dynamic> json) {
    return json['itens']
        ?.map<ItemModel>((json) => ItemModel.fromJson(json))
        .toList();
  }

  List<ItemCategoryModel>? itemCategoryList(Map<String, dynamic> json) {
    return json['categoriaItens']
        ?.map<ItemCategoryModel>((json) => ItemCategoryModel.fromJson(json))
        .toList();
  }

  List<PeriodModel>? periodList(Map<String, dynamic> json) {
    return json['periodos']
        ?.map<PeriodModel>((json) => PeriodModel.fromJson(json))
        .toList();
  }
}
