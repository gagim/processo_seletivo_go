class ItemCategoryModel {
  String? nome;
  String? icone;

  ItemCategoryModel({this.nome, this.icone});

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'icone': icone};
  }

  ItemCategoryModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    icone = json['icone'];
  }
}
