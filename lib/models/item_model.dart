class ItemModel {
  String? nome;

  ItemModel({this.nome});

  Map<String, dynamic> toMap() {
    return {'nome': nome};
  }

  ItemModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
  }
}
