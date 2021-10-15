import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/clients_controller.dart';
import 'package:vendas/app/controllers/new_request_controller.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/requests_controller.dart';
import 'package:vendas/app/models/client_model.dart';
import 'package:vendas/app/models/product_amount_model.dart';
import 'package:vendas/app/models/request_model.dart';
import 'package:vendas/app/routes/constantes.dart';

class NewRequestWidget extends StatelessWidget {
  const NewRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientsController = Provider.of<ClientsController>(context);
    final requestsController = Provider.of<RequestsController>(context);
    final productsController = Provider.of<ProductsController>(context);
    final newRequestController = Provider.of<NewRequestController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Novo Pedido',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87.withOpacity(0.75),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Escolha um cliente',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Bw-Medium',
                  color: Colors.black.withOpacity(
                    0.75,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.black.withOpacity(
                      0.75,
                    ),
                  ),
                ),
                child: DropdownButton<ClientModel>(
                  icon: Expanded(
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(
                          FontAwesomeIcons.caretDown,
                        ),
                      ],
                    ),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    requestsController.setCurrentRequestClient(value!);
                  },
                  value: requestsController.currentRequestClient,
                  items: clientsController.clients
                      .map(
                        (e) => DropdownMenuItem<ClientModel>(
                          value: e,
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Bw-Medium',
                              color: Colors.black.withOpacity(
                                0.75,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Escolha os produtos',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Bw-Medium',
                  color: Colors.black.withOpacity(
                    0.75,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: productsController.productsLength,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      onTap: () {
                        if (newRequestController.indexs.contains(index)) {
                          newRequestController.remove(index);
                        } else {
                          newRequestController.add(index);
                        }
                      },
                      selectedTileColor: Colors.blueAccent.withOpacity(0.2),
                      selected: newRequestController.indexs.contains(index),
                      title: Text(
                        productsController.products[index].name,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  if (await requestsController.newrequest(
                    RequestModel(
                      currentDateTime: DateTime.now(),
                      client: requestsController.currentRequestClient,
                      products: newRequestController.indexs
                          .map(
                            (e) => ProductAmountModel(
                                product: productsController.products[e],
                                quantity: 1),
                          )
                          .toList(),
                    ),
                  )) {
                    Navigator.pushNamed(context, Constantes.kHome);
                  } else {}
                },
                child: const Text(
                  'SALVAR',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
