import 'package:vendas/app/models/client_model.dart';
import 'package:vendas/app/models/product_amount_model.dart';

class RequestModel {
  List<ProductAmountModel>? products;
  ClientModel? client;

  DateTime? currentDateTime;
  bool delivered;
  bool paidOut;

  RequestModel({
    this.products,
    this.client,
    this.currentDateTime,
    this.delivered = false,
    this.paidOut = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'products': products!.map((x) => x.toMap()).toList(),
      'client': client!.toMap(),
      'currentDateTime': currentDateTime!.millisecondsSinceEpoch,
      'delivered': delivered,
      'paidOut': paidOut,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      products: List<ProductAmountModel>.from(
          map['products']?.map((x) => ProductAmountModel.fromMap(x))),
      client: ClientModel.fromMap(map['client']),
      currentDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['currentDateTime']),
      delivered: map['delivered'],
      paidOut: map['paidOut'],
    );
  }
}
