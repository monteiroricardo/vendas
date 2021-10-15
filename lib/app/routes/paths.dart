import 'package:flutter/material.dart';
import 'package:vendas/app/routes/constantes.dart';
import 'package:vendas/app/views/home/home_view.dart';
import 'package:vendas/app/views/home/widgets/requests/widgets/new_request_widget.dart';
import 'package:vendas/app/views/splash/splash_view.dart';

class Paths {
  static Map<String, Widget Function(BuildContext)> paths = {
    Constantes.kHome: (_) => const HomeView(),
    Constantes.kSplash: (_) => const SplashView(),
    Constantes.kNewRequest: (_) => const NewRequestWidget(),
  };
}
