import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/clients_controller.dart';
import 'package:vendas/app/models/client_model.dart';

class ClientItemWidget extends StatelessWidget {
  final ClientModel cli;
  final int index;
  const ClientItemWidget({
    Key? key,
    required this.cli,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientsController = Provider.of<ClientsController>(context);
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: SizedBox(
              height: 75,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 12,
                        right: 12,
                        bottom: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cli.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bw-Bold',
                              color: Colors.black.withOpacity(
                                0.75,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            height: 0.2,
                            color: Colors.black38,
                          ),
                          Text(
                            cli.number!,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Bw-Bold',
                              color: Colors.greenAccent[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          // onTap: () async {
          //   viewController.setLoading();
          //   await clientsController.removeClient(index);
          //   viewController.setLoading();
          // },
          onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('Excluir'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent[400],
                        ),
                        onPressed: () async {
                          await clientsController.removeClient(index);

                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sim',
                          style: TextStyle(
                              fontFamily: 'Baloo-Bold', color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent[400],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Não',
                          style: TextStyle(
                              fontFamily: 'Baloo-Bold', color: Colors.white),
                        ),
                      ),
                    ],
                  )),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: SizedBox(
              width: 50,
              height: 75,
              child: Icon(
                FontAwesomeIcons.trash,
                color: Colors.redAccent[400]!.withOpacity(
                  0.7,
                ),
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
