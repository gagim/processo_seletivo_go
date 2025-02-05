class GenericResponseModel {
  String? message;

  GenericResponseModel({this.message});

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  GenericResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? json['detail'];
  }
}
