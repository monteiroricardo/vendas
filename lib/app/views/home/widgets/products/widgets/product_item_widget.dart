import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/view_controller.dart';

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
    final viewController = Provider.of<ViewController>(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Container(
        height: 85,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 12,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prod.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.black38,
                    ),
                    Text(
                      'R\$ ${prod.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.greenAccent[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                viewController.setLoading();
                await productController.removeProduct(index);
                viewController.setLoading();
              },
              icon: Icon(
                FontAwesomeIcons.trash,
                color: Colors.black.withOpacity(
                  0.35,
                ),
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
/**InkWell(
                      onTap: () async {
                        viewController.setLoading();
                        await productController.updateProduct(index);
                        viewController.setLoading();
                      },
                      onDoubleTap: () async {
                        viewController.setLoading();
                        await productController.removeProduct(index);
                        viewController.setLoading();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        height: 50,
                        width: 200,
                        color: Colors.redAccent[400],
                        child: Text(
                          prod.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ); */