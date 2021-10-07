import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/products_controller.dart';
import 'package:vendas/app/controllers/view_controller.dart';
import 'package:vendas/app/models/product_model.dart';
import 'package:vendas/app/views/home/widgets/products/widgets/product_item_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    final viewController = Provider.of<ViewController>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meus Produtos',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87.withOpacity(0.75),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: productController.productsLength,
                  itemBuilder: (ctx, index) {
                    final prod = productController.products[index];
                    return ProductItemWidget(
                      prod: prod,
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
        onPressed: () async {
          viewController.setLoading();
          if (await productController.newProduct(
            ProductModel(
              name: 'TESTE',
              price: 20.50,
            ),
          )) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'SUCCESS',
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'ERROR',
                ),
              ),
            );
          }
          viewController.setLoading();
        },
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
    );
  }
}
