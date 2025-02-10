import 'package:flutter/material.dart';
import 'package:processo_seletivo_go/helpers/masks.dart';
import 'package:processo_seletivo_go/models/suite_model.dart';
import 'package:processo_seletivo_go/views/homePage/home_page_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  MonitoringState createState() => MonitoringState();
}

class MonitoringState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    final HomePageController controller = HomePageController();
    controller.getMotelsList(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text('Home',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: AnimatedBuilder(
                key: const Key('animatedBuilderKey'),
                animation: Listenable.merge([
                  controller.isLoading,
                  controller.erroMsg,
                  controller.motelResponse
                ]),
                builder: (context, child) {
                  if (controller.isLoading.value) {
                    return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        child: const CircularProgressIndicator());
                  }

                  if (controller.erroMsg.value.isNotEmpty) {
                    return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            key: const Key('errorMsgTextKey'),
                            controller.erroMsg.value,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }

                  if (controller.motelResponse.value.sucesso == null) {
                    return const Center(
                      child: Text(
                        key: Key('emptyMsgTextKey'),
                        'Sem itens a mostrar',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListView.separated(
                            separatorBuilder: (c, i) =>
                                const SizedBox(height: 20),
                            padding: const EdgeInsets.all(16),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller
                                    .motelResponse.value.data?.totalMoteis ??
                                0,
                            itemBuilder: (_, i) {
                              final widthCardSuit =
                                  MediaQuery.of(context).size.width * 0.8;

                              final item = controller
                                  .motelResponse.value.data?.moteis?[i];
                              final locate = Masks().maskLocate(
                                  item?.distancia ?? 0, item?.bairro ?? "");

                              return Card(
                                  elevation: 4,
                                  shadowColor: Colors.black,
                                  color: Colors.white,
                                  child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Column(children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.network(
                                                      key: const Key(
                                                          'imagemMotel'),
                                                      item?.logo ?? "",
                                                      height: 50.0,
                                                      width: 50.0,
                                                      fit: BoxFit.cover),
                                                ),
                                              ]),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                  child: ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: Text(
                                                        key: const Key(
                                                            'fantasiaNameKey'),
                                                        item?.fantasia ?? "",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        key: const Key(
                                                            'locateKey'),
                                                        locate,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                      ))),
                                            ],
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (int index = 0;
                                                      index <
                                                          item!.suites!.length;
                                                      index++)
                                                    motelAdapter(
                                                        widthCardSuit,
                                                        item.suites![index],
                                                        index),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )));
                            },
                          )
                        ]);
                  }
                })));
  }

  Widget motelAdapter(double widthCardSuit, SuiteModel suit, int index) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(right: 10),
      width: widthCardSuit,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1,
            color: Colors.redAccent,
          )),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 210.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              suit.fotos?[0] ?? "",
              fit: BoxFit.fill,
              key: Key('suitImageKey$index'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          key: Key('suitNameKey$index'),
          textAlign: TextAlign.center,
          suit.nome ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.all(15.0),
          color: Colors.redAccent,
        ),
        const SizedBox(height: 20),
        ListView.separated(
            separatorBuilder: (c, i) => const SizedBox(height: 10),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: suit.periodos?.length ?? 0,
            itemBuilder: (_, i) {
              final period = suit.periodos?[i];

              final valor = Masks().maskMonetary(period?.valorTotal ?? 0);

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 1,
                      color: Colors.redAccent,
                    )),
                child: ListTile(
                    title: Text(
                      key: Key('periodoTimeKey$index$i'),
                      period?.tempoFormatado ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      key: Key('valorPeriodoKey$index$i'),
                      valor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    )),
              );
            })
      ]),
    );
  }
}
