import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:processo_seletivo_go/base/enums.dart';
import 'package:processo_seletivo_go/models/generic_response_model.dart';
import 'package:processo_seletivo_go/models/handler_response_model.dart';

abstract class HttpClient {
  Future<HandlerResponseModel?> httpRequest<T>(
      String endPoint,
      RequestMethod method,
      T Function(Map<String, dynamic> json) fromJson,
      Object? body);
}

class HttpClientImpl implements HttpClient {
  @override
  Future<HandlerResponseModel?> httpRequest<T>(
      String endPoint,
      RequestMethod method,
      T Function(Map<String, dynamic> json) fromJson,
      Object? body) async {
    http.Response resp;
    final Uri url = Uri.parse(endPoint);
    final Map<String, String> headers = <String, String>{};

    try {
      switch (method) {
        case RequestMethod.get:
          resp = await http.get(
            url,
            headers: headers,
          );
        case RequestMethod.put:
          resp = await http.put(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
        case RequestMethod.post:
          resp = await http.post(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
        case RequestMethod.delete:
          resp = await http.delete(
            url,
            headers: headers,
          );
      }

      var jsonDecode = json.decode(utf8.decode(resp.bodyBytes));

      if (resp.statusCode == 200 ||
          resp.statusCode == 201 ||
          resp.statusCode == 202) {
        return HandlerResponseModel(
            type: HandlersTypes.sucess,
            status: resp.statusCode,
            response: fromJson(jsonDecode));
      } else {
        GenericResponseModel? genericResponseModel =
            GenericResponseModel.fromJson(jsonDecode);
        return HandlerResponseModel(
            type: HandlersTypes.erro,
            status: resp.statusCode,
            response: genericResponseModel);
      }
    } on TimeoutException catch (e) {
      GenericResponseModel genericResponseModel =
          GenericResponseModel(message: e.message);

      return HandlerResponseModel(
          type: HandlersTypes.timeOut,
          status: 0,
          response: genericResponseModel);
    } on SocketException catch (e) {
      GenericResponseModel genericResponseModel =
          GenericResponseModel(message: e.message);

      return HandlerResponseModel(
          type: HandlersTypes.erro,
          status: e.hashCode,
          response: genericResponseModel);
    } on Error catch (e) {
      GenericResponseModel genericResponseModel =
          GenericResponseModel(message: e.toString());
      return HandlerResponseModel(
          type: HandlersTypes.erro,
          status: e.hashCode,
          response: genericResponseModel);
    }
  }
}
