import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:processo_seletivo_go/helpers/load_mock.dart';
import 'package:processo_seletivo_go/helpers/masks.dart';
import 'package:processo_seletivo_go/http/http_client.dart';
import 'package:processo_seletivo_go/models/data_model.dart';
import 'package:processo_seletivo_go/models/motel_model.dart';
import 'package:processo_seletivo_go/models/motel_response_model.dart';
import 'package:processo_seletivo_go/models/suite_model.dart';
import 'package:processo_seletivo_go/providers/motel_provider.dart';
import 'package:processo_seletivo_go/views/homePage/home_page_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    print('Inicio do teste');
  });

  tearDown(() {
    print('Fim do teste');
  });

  Map<String, dynamic> mockData = await LoadMock()
      .loadJsonFromAssets('assets/mocks/motel_response_mock.json');

  final MotelResponseModel motelResponse =
      MotelResponseModel.fromJson(mockData);
  final motels = DataModel().motelList(mockData['data']);

  final locate = Masks().maskLocate(
      motelResponse.data?.moteis?[0].distancia ?? 0,
      motelResponse.data?.moteis?[0].bairro ?? "");

  testWidgets('Testar a listagem de hoteis (Sucesso)',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Provider<IMotelProvider>(
            builder: (c, w) {
              return const HomePageView();
            },
            create: (_) => MotelProvider(client: HttpClientImpl()),
            lazy: true)));

    await tester.pumpAndSettle();

    final imagemMotelKey = find.byKey(const Key('imagemMotel'));
    expect(imagemMotelKey, findsOneWidget);
    expect(find.image(NetworkImage(motelResponse.data!.moteis![0].logo!)),
        findsOneWidget);

    final fantasiaNameKey = find.byKey(const Key('fantasiaNameKey'));
    expect(fantasiaNameKey, findsOneWidget);
    Text fantasiaName = tester.firstWidget(fantasiaNameKey);
    expect(fantasiaName.data, motelResponse.data?.moteis?[0].fantasia);

    final locateKey = find.byKey(const Key('locateKey'));
    expect(locateKey, findsOneWidget);
    Text locateName = tester.firstWidget(locateKey);
    expect(locateName.data, locate);

    for (int iM = 0; iM < motels!.length; iM++) {
      final suits = MotelModel().suiteList(mockData['data']['moteis'][iM]);

      for (int iS = 0; iS < suits.length; iS++) {
        final newPersonFinder = find.byKey(Key('suitImageKey$iS'));
        expect(newPersonFinder, findsOneWidget);
        expect(find.image(NetworkImage(suits[iS].fotos![0])), findsOneWidget);

        final suitNameKey = find.byKey(Key('suitNameKey$iS'));
        expect(suitNameKey, findsOneWidget);
        Text suitName = tester.firstWidget(suitNameKey);
        expect(suitName.data, suits[iS].nome);

        final periodoItens = SuiteModel()
            .periodList(mockData['data']['moteis'][iM]['suites'][iS]);

        for (int iP = 0; iP < periodoItens!.length; iP++) {
          final valor = Masks().maskMonetary(periodoItens[iP].valorTotal ?? 0);

          final periodTimeKey = find.byKey(Key('periodoTimeKey$iS$iP'));
          expect(periodTimeKey, findsOneWidget);
          Text periodTime = tester.firstWidget(periodTimeKey);
          expect(periodTime.data, periodoItens[iP].tempoFormatado);

          final valorPeriodoKey = find.byKey(Key('valorPeriodoKey$iS$iP'));
          expect(valorPeriodoKey, findsOneWidget);
          Text valorPeriodo = tester.firstWidget(valorPeriodoKey);
          expect(valorPeriodo.data, valor);
        }
      }
    }
  });
}
