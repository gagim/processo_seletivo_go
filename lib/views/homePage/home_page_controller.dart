import 'package:flutter/cupertino.dart';
import 'package:processo_seletivo_go/base/enums.dart';
import 'package:processo_seletivo_go/models/generic_response_model.dart';
import 'package:processo_seletivo_go/models/motel_response_model.dart';
import 'package:processo_seletivo_go/providers/motel_provider.dart';
import 'package:provider/provider.dart';

class HomePageController {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  final ValueNotifier<MotelResponseModel> motelResponse =
      ValueNotifier(MotelResponseModel());

  final ValueNotifier<String> erroMsg = ValueNotifier('');

  Future getMotelsList(BuildContext context) async {
    IMotelProvider provider = context.read<IMotelProvider>();

    isLoading.value = true;

    final result = await provider.getMotels();

    switch (result?.type) {
      case null:
        erroMsg.value = "Error inesperado";
      case HandlersTypes.sucess:
        motelResponse.value = result?.response as MotelResponseModel;
      case HandlersTypes.erro ||
            HandlersTypes.timeOut ||
            HandlersTypes.negocialErro:
        final genericResponse = result?.response as GenericResponseModel;
        erroMsg.value = genericResponse.message ?? "";
    }

    isLoading.value = false;
  }
}
