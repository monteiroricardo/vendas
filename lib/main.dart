import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/clients_controller.dart';
import 'package:vendas/app/controllers/new_request_controller.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/requests_controller.dart';
import 'package:vendas/app/controllers/view_controller.dart';
import 'package:vendas/app/routes/constantes.dart';
import 'package:vendas/app/routes/paths.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ClientsController(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductsController(),
      ),
      ChangeNotifierProvider(
        create: (_) => RequestsController(),
      ),
      ChangeNotifierProvider(
        create: (_) => ViewController(),
      ),
      ChangeNotifierProvider(
        create: (_) => NewRequestController(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Paths.paths,
        initialRoute: Constantes.kSplash,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt', 'BR')
        ]),
  ));
}
