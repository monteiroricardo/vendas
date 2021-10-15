import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/requests_controller.dart';
import 'package:vendas/app/routes/constantes.dart';
import 'package:vendas/app/views/home/widgets/requests/widgets/request_item_widget.dart';

class RequestsWidget extends StatefulWidget {
  const RequestsWidget({Key? key}) : super(key: key);

  @override
  State<RequestsWidget> createState() => _RequestsWidgetState();
}

class _RequestsWidgetState extends State<RequestsWidget> {
  @override
  Widget build(BuildContext context) {
    final requestController = Provider.of<RequestsController>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meus Pedidos',
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
                  itemCount: requestController.requestsLength,
                  itemBuilder: (ctx, index) {
                    final req = requestController.requests[index];
                    return RequestItemWidget(
                      req: req,
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
        onPressed: () => Navigator.pushNamed(
          context,
          Constantes.kNewRequest,
        ),
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
    );
  }
}
