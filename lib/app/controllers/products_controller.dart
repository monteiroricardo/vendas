import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vendas/app/models/product_model.dart';
import 'package:vendas/app/path_provider/manage_path.dart';

class ProductsController extends ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => [..._products];
  int get productsLength => _products.length;

  Future<bool> newProduct(ProductModel prod) async {
    try {
      _products.add(prod);
      File productsPath = await getProductsPath();
      List<Map<dynamic, dynamic>> data =
          _products.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(
        productsPath,
        data,
      );
      await readProducts();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(int productId) async {
    try {
      _products[productId].name = 'atualizado';
      File productsPath = await getProductsPath();
      List<Map<dynamic, dynamic>> data =
          _products.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(productsPath, data);
      await readProducts();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeProduct(int productId) async {
    try {
      _products.removeAt(productId);
      File productsPath = await getProductsPath();
      List<Map<dynamic, dynamic>> data =
          _products.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(productsPath, data);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  readProducts() async {
    List<ProductModel> newData = [];
    File productsPath = await getProductsPath();
    List data = await ManagePath.readDataFromDevice(productsPath);
    for (var item in data) {
      newData.add(
        ProductModel.fromMap(item),
      );
    }
    _products = newData;
    notifyListeners();
  }

  Future<File> getProductsPath() async {
    return await ManagePath.getPath('products');
  }
}
