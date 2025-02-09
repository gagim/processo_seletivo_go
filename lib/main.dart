import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:processo_seletivo_go/base/constants.dart';
import 'package:processo_seletivo_go/base/custom_colors.dart';
import 'package:processo_seletivo_go/http/http_client.dart';
import 'package:processo_seletivo_go/providers/motel_provider.dart';
import 'package:processo_seletivo_go/views/homePage/home_page_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.red),
          useMaterial3: true),
      scrollBehavior: const ScrollBehavior(),
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        Provider<IMotelProvider>(
          create: (_) => MotelProvider(client: HttpClientImpl()),
          lazy: true,
        ),
        Provider<IMotelProvider>(
          create: (_) => MotelProvider(client: HttpClientImpl()),
          lazy: true,
        )
      ], child: const HomePageView())));
}
