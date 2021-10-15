import 'package:vendas/app/models/product_model.dart';

class ProductAmountModel {
  ProductModel product;
  int quantity;
  ProductAmountModel({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory ProductAmountModel.fromMap(Map<String, dynamic> map) {
    return ProductAmountModel(
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}
