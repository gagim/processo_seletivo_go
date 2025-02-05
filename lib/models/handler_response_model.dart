import 'package:processo_seletivo_go/base/enums.dart';

class HandlerResponseModel {
  HandlersTypes? type;
  int? status;
  Object? response;

  HandlerResponseModel({this.type, this.status, this.response});

  Map<String, dynamic> toMap() {
    return {'type': type, 'status': status, 'response': response};
  }

  HandlerResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    response = json['response'];
  }
}
