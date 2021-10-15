import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vendas/app/models/client_model.dart';
import 'package:vendas/app/models/product_amount_model.dart';
import 'package:vendas/app/models/request_model.dart';
import 'package:vendas/app/path_provider/manage_path.dart';

class RequestsController extends ChangeNotifier {
  List<RequestModel> _requests = [];

  int currentIndexEnabled = 0;

  void setCurrentIndexEnabled(int newIndex) {
    currentIndexEnabled = newIndex;
    notifyListeners();
  }

  ClientModel? currentRequestClient;

  setCurrentRequestClient(ClientModel cli) {
    currentRequestClient = cli;
    notifyListeners();
  }

  List<RequestModel> get requests => [..._requests];
  int get requestsLength => _requests.length;

  double getTotalAmount(requestId) {
    double totalAmount = 0;
    for (var element in _requests[requestId].products!) {
      totalAmount += element.product.price * element.quantity;
    }
    return totalAmount;
  }

  RequestModel newrequestModel = RequestModel(products: []);

  Future<bool> newrequest(RequestModel req) async {
    try {
      _requests.add(req);
      File requestsPath = await getrequestsPath();
      List<Map<dynamic, dynamic>> data =
          _requests.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(
        requestsPath,
        data,
      );
      await readRequests();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removerequest(int requestId) async {
    return await update(() {
      _requests.removeAt(requestId);
    });
  }

  Future<bool> addItemInProductOfRequest(int productId, int requestId) async {
    return await update(() {
      _requests[requestId].products![productId].quantity++;
    });
  }

  Future<bool> addProductInRequest(
      int requestId, ProductAmountModel pro) async {
    return await update(() {
      _requests[requestId].products!.add(pro);
    });
  }

  Future<bool> removeItemInProductOfRequest(
      int productId, int requestId) async {
    if (_requests[requestId].products![productId].quantity == 1) {
      return await update(() {
        _requests[requestId].products!.removeAt(productId);
      });
    } else {
      return await update(() {
        _requests[requestId].products![productId].quantity--;
      });
    }
  }

  Future<bool> removeProductOfRequest(int productId, int requestId) async {
    return await update(() {
      _requests[requestId].products!.removeAt(productId);
    });
  }

  Future<bool> setpaidOut(int requestId) async {
    return await update(() {
      _requests[requestId].paidOut = !_requests[requestId].paidOut;
    });
  }

  Future<bool> setDelivered(int requestId) async {
    return await update(() {
      _requests[requestId].delivered = !_requests[requestId].delivered;
    });
  }

  Future<bool> update(Function func) async {
    try {
      func();
      File requestsPath = await getrequestsPath();
      List<Map<dynamic, dynamic>> data =
          _requests.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(requestsPath, data);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  readRequests() async {
    List<RequestModel> newData = [];
    File requestsPath = await getrequestsPath();
    List data = await ManagePath.readDataFromDevice(requestsPath);
    for (var item in data) {
      newData.add(
        RequestModel.fromMap(item),
      );
    }
    _requests = newData;
    notifyListeners();
  }

  Future<File> getrequestsPath() async {
    return await ManagePath.getPath('requests');
  }
}
