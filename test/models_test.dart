import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:processo_seletivo_go/helpers/load_mock.dart';
import 'package:processo_seletivo_go/models/data_model.dart';
import 'package:processo_seletivo_go/models/motel_model.dart';
import 'package:processo_seletivo_go/models/motel_response_model.dart';
import 'package:processo_seletivo_go/models/suite_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, dynamic> mockData = await LoadMock()
      .loadJsonFromAssets('assets/mocks/motel_response_mock.json');

  final motelResponse = MotelResponseModel.fromJson(mockData);
  final dataResponse = DataModel.fromJson(mockData['data']);
  final motels = DataModel().motelList(mockData['data']);

  group("Grupo de teste para validar as models usadas pela API hoteis", () {
    test("Teste da model hotel response", () {
      expect(motelResponse.sucesso, true);
      expect(motelResponse.mensagem, []);
    });

    test("Teste da model data", () {
      expect(motelResponse.data?.pagina, dataResponse.pagina);
      expect(motelResponse.data?.qtdPorPagina, dataResponse.qtdPorPagina);
      expect(motelResponse.data?.totalSuites, dataResponse.totalSuites);
      expect(motelResponse.data?.totalMoteis, dataResponse.totalMoteis);
      expect(motelResponse.data?.raio, dataResponse.raio);
      expect(motelResponse.data?.maxPaginas, dataResponse.maxPaginas);
    });

    test("teste da model moteis", () {
      for (int iM = 0; iM < motels!.length; iM++) {
        expect(dataResponse.moteis?[iM].fantasia, motels[iM].fantasia);
        expect(dataResponse.moteis?[iM].logo, motels[iM].logo);
        expect(dataResponse.moteis?[iM].bairro, motels[iM].bairro);
        expect(dataResponse.moteis?[iM].distancia, motels[iM].distancia);
        expect(dataResponse.moteis?[iM].qtdFavoritos, motels[iM].qtdFavoritos);
        expect(
            dataResponse.moteis?[iM].qtdAvaliacoes, motels[iM].qtdAvaliacoes);
        expect(dataResponse.moteis?[iM].media, motels[iM].media);
      }
    });

    test("teste da model suites", () {
      for (int iM = 0; iM < motels!.length; iM++) {
        final suits = MotelModel().suiteList(mockData['data']['moteis'][iM]);

        for (int iS = 0; iS < suits.length; iS++) {
          expect(motels[iM].suites?[iS].nome, suits[iS].nome);
          expect(motels[iM].suites?[iS].qtd, suits[iS].qtd);
          expect(motels[iM].suites?[iS].exibirQtdDisponiveis,
              suits[iS].exibirQtdDisponiveis);

          //Itens model teste
          final itens = SuiteModel()
              .itemList(mockData['data']['moteis'][iM]['suites'][iS]);

          for (int iI = 0; iI < itens!.length; iI++) {
            expect(motels[iM].suites?[iS].itens?[iI].nome, itens[iI].nome);
          }

          //Categoria itens model teste
          final categoriaItens = SuiteModel()
              .itemCategoryList(mockData['data']['moteis'][iM]['suites'][iS]);

          for (int iC = 0; iC < categoriaItens!.length; iC++) {
            expect(motels[iM].suites?[iS].categoriaItens?[iC].nome,
                categoriaItens[iC].nome);
            expect(motels[iM].suites?[iS].categoriaItens?[iC].icone,
                categoriaItens[iC].icone);
          }

          //Periodo model teste
          final periodoItens = SuiteModel()
              .periodList(mockData['data']['moteis'][iM]['suites'][iS]);

          for (int iP = 0; iP < periodoItens!.length; iP++) {
            expect(motels[iM].suites?[iS].periodos?[iP].tempoFormatado,
                periodoItens[iP].tempoFormatado);
            expect(motels[iM].suites?[iS].periodos?[iP].tempo,
                periodoItens[iP].tempo);
            expect(motels[iM].suites?[iS].periodos?[iP].valor,
                periodoItens[iP].valor);
            expect(motels[iM].suites?[iS].periodos?[iP].valorTotal,
                periodoItens[iP].valorTotal);
            expect(motels[iM].suites?[iS].periodos?[iP].temCortesia,
                periodoItens[iP].temCortesia);
            expect(motels[iM].suites?[iS].periodos?[iP].desconto?.desconto,
                periodoItens[iP].desconto?.desconto);
          }
        }
      }
    });
  });
}
