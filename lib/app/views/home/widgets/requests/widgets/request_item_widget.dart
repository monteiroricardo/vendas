import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/requests_controller.dart';
import 'package:vendas/app/models/product_amount_model.dart';
import 'package:vendas/app/models/product_model.dart';

import 'package:vendas/app/models/request_model.dart';

class RequestItemWidget extends StatelessWidget {
  final RequestModel req;
  final int index;
  const RequestItemWidget({
    Key? key,
    required this.req,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat(
      'dd/M/y',
      'pt_BR',
    );
    final requestController = Provider.of<RequestsController>(context);
    final productsController = Provider.of<ProductsController>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  req.client!.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Bw-Bold',
                    color: Colors.black.withOpacity(
                      0.75,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('Excluir'),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.greenAccent[400],
                                  ),
                                  onPressed: () async {
                                    await requestController
                                        .removerequest(index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Sim',
                                    style: TextStyle(
                                        fontFamily: 'Baloo-Bold',
                                        color: Colors.white),
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
                                        fontFamily: 'Baloo-Bold',
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                    icon: Icon(
                      FeatherIcons.moreVertical,
                      size: 18.5,
                      color: Colors.black.withOpacity(
                        0.6,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                formatDate.format(req.currentDateTime!),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Bw-Medium',
                  color: Colors.black.withOpacity(
                    0.40,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: requestController.requests[index].delivered,
                  onChanged: (value) async {
                    requestController.setDelivered(index);
                  },
                ),
                const Text(
                  'Entrege',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Bw-Medium',
                    color: Colors.black87,
                  ),
                ),
                Checkbox(
                  value: requestController.requests[index].paidOut,
                  onChanged: (value) async {
                    requestController.setpaidOut(index);
                  },
                ),
                const Text(
                  'Pago',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Bw-Medium',
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Text(
                  'R\$ ${requestController.getTotalAmount(index)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Bw-Medium',
                    color: Colors.greenAccent[700],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              title: Text(
                'Detalhes',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Bw-Medium',
                  color: Colors.black.withOpacity(
                    0.75,
                  ),
                ),
              ),
              children: [
                ...req.products!.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              e.product.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Bw-Medium',
                                color: Colors.black.withOpacity(
                                  0.75,
                                ),
                              ),
                            ),
                            ...List.generate(
                              400 ~/ 10,
                              (index) => Expanded(
                                child: Container(
                                  color: index % 2 == 0
                                      ? Colors.transparent
                                      : Colors.grey,
                                  height: 1,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                              ),
                              width: 80,
                              child: Text(
                                'R\$ ${(e.product.price * e.quantity).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Bw-Medium',
                                  color: Colors.greenAccent[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  requestController.addItemInProductOfRequest(
                                    req.products!.indexOf(e),
                                    index,
                                  );
                                },
                                child: Card(
                                  elevation: 0.5,
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      FeatherIcons.plus,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.70),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      ' x ${e.quantity}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Bw-Medium',
                                        color: Colors.black.withOpacity(
                                          0.70,
                                        ),
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () async {
                                  requestController
                                      .removeItemInProductOfRequest(
                                          req.products!.indexOf(e), index);
                                },
                                child: Card(
                                  elevation: 0.5,
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      FeatherIcons.minus,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.70),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<ProductModel>(
                  onSelected: (value) {
                    requestController.addProductInRequest(
                        index,
                        ProductAmountModel(
                            product: productsController.products[
                                productsController.products.indexOf(value)],
                            quantity: 1));
                  },
                  icon: const Icon(FontAwesomeIcons.plus),
                  itemBuilder: (ctx) => productsController.products
                      .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
