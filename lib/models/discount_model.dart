class DiscountModel {
  double? desconto;

  DiscountModel({this.desconto});

  Map<String, dynamic> toMap() {
    return {'desconto': desconto};
  }

  DiscountModel.fromJson(Map<String, dynamic> json) {
    desconto = json['desconto'];
  }
}
