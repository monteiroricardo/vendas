import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vendas/app/models/client_model.dart';
import 'package:vendas/app/path_provider/manage_path.dart';

class ClientsController extends ChangeNotifier {
  List<ClientModel> _clients = [];

  List<ClientModel> get clients => [..._clients];
  int get clientsLength => _clients.length;

  ClientModel newClientModel = ClientModel(name: '', number: '', addres: '');

  String selectedClientValue = 'Antônio';

  setSelectedCLientValue(String newValue) {
    selectedClientValue = newValue;
    notifyListeners();
  }

  Future<bool> newClient() async {
    try {
      _clients.add(newClientModel);
      File clientsPath = await getClientsPath();
      List<Map<dynamic, dynamic>> data =
          _clients.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(
        clientsPath,
        data,
      );
      await readClients();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateClient(int clientId) async {
    try {
      _clients[clientId].name = 'atualizado';
      File clientsPath = await getClientsPath();
      List<Map<dynamic, dynamic>> data =
          _clients.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(clientsPath, data);
      await readClients();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeClient(int clientId) async {
    try {
      _clients.removeAt(clientId);
      File clientsPath = await getClientsPath();
      List<Map<dynamic, dynamic>> data =
          _clients.map((element) => element.toMap()).toList();
      await ManagePath.saveDataInDevice(clientsPath, data);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  readClients() async {
    List<ClientModel> newData = [];
    File clientsPath = await getClientsPath();
    List data = await ManagePath.readDataFromDevice(clientsPath);
    for (var item in data) {
      newData.add(
        ClientModel.fromMap(item),
      );
    }
    _clients = newData;
    notifyListeners();
  }

  Future<File> getClientsPath() async {
    return await ManagePath.getPath('clients');
  }
}
