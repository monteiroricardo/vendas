import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/clients_controller.dart';
import 'package:vendas/app/controllers/view_controller.dart';
import 'package:vendas/app/views/home/widgets/clients/widgets/client_item_widget.dart';

class ClientsWidget extends StatefulWidget {
  const ClientsWidget({Key? key}) : super(key: key);

  @override
  State<ClientsWidget> createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> {
  GlobalKey<FormState> clientsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final clientController = Provider.of<ClientsController>(context);
    final viewController = Provider.of<ViewController>(context);
    void newProduct() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                20,
              ),
            ),
          ),
          child: Form(
            key: clientsKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.trim().isNotEmpty) {
                        clientController.newClientModel.name = value;
                        return null;
                      } else {
                        return 'campo vazio';
                      }
                    } else {
                      return 'campo vazio';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'Nome',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.trim().isNotEmpty) {
                        clientController.newClientModel.number = value;
                        return null;
                      } else {
                        return 'campo vazio';
                      }
                    } else {
                      return 'campo vazio';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'WhatsApp',
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () async {
                    if (clientsKey.currentState!.validate()) {
                      viewController.setLoading();
                      if (await clientController.newClient()) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'SUCCESS',
                            ),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'ERROR',
                            ),
                          ),
                        );
                      }
                      viewController.setLoading();
                    }
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

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meus Clientes',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87.withOpacity(0.75),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: clientController.clientsLength,
                  itemBuilder: (ctx, index) {
                    final cli = clientController.clients[index];
                    return ClientItemWidget(
                      cli: cli,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => newProduct(),
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
    );
  }
}
