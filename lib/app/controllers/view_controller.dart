import 'package:flutter/material.dart';
import 'package:vendas/app/views/home/widgets/clients/clients_widget.dart';
import 'package:vendas/app/views/home/widgets/products/products_widget.dart';
import 'package:vendas/app/views/home/widgets/requests/requests_widget.dart';

class ViewController extends ChangeNotifier {
  List<Widget> views = const [
    ProductsWidget(),
    RequestsWidget(),
    ClientsWidget(),
  ];
  int currentViewIndex = 0;
  bool isLoading = false;

  void setCurrentViewIndex(int index) {
    currentViewIndex = index;
    notifyListeners();
  }

  Widget getCurrentView() {
    return views[currentViewIndex];
  }

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
