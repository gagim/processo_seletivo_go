import 'package:processo_seletivo_go/base/end_points.dart';
import 'package:processo_seletivo_go/base/enums.dart';
import 'package:processo_seletivo_go/http/http_client.dart';
import 'package:processo_seletivo_go/models/handler_response_model.dart';
import 'package:processo_seletivo_go/models/motel_response_model.dart';

abstract class IMotelProvider {
  Future<HandlerResponseModel?> getMotels();
}

class MotelProvider implements IMotelProvider {
  final HttpClient client;

  MotelProvider({required this.client});

  @override
  Future<HandlerResponseModel?> getMotels() async {
    final response = await client.httpRequest(EndPoints.API, RequestMethod.get,
        (json) => MotelResponseModel.fromJson(json), null);

    return response;
  }
}
