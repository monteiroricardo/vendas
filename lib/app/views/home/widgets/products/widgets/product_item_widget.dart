import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/products_controller.dart';

import 'package:vendas/app/models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel prod;
  final int index;
  const ProductItemWidget({
    Key? key,
    required this.prod,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
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
                            prod.name,
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
                            'R\$ ${prod.price.toStringAsFixed(2)}',
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
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: SizedBox(
            width: 50,
            height: 75,
            child: IconButton(
              // onPressed: () async {
              //   viewController.setLoading();
              //   await productController.removeProduct(index);
              //   viewController.setLoading();
              // },
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
                              await productController.removeProduct(index);

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
                              'N??o',
                              style: TextStyle(
                                  fontFamily: 'Baloo-Bold',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )),
              icon: Icon(
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
