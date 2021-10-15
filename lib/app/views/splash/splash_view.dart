import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/clients_controller.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/requests_controller.dart';
import 'package:vendas/app/routes/constantes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void goToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushNamedAndRemoveUntil(
        context, Constantes.kHome, (route) => false);
  }

  @override
  void initState() {
    Provider.of<ProductsController>(context, listen: false).readProducts();
    Provider.of<ClientsController>(context, listen: false).readClients();
    Provider.of<RequestsController>(context, listen: false).readRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    goToHome();
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  const Text(
                    'Vendas',
                    style: TextStyle(
                        fontFamily: 'Baloo-Bold',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent[100],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.lightBlueAccent[700]!,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
