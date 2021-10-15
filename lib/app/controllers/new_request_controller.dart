import 'package:flutter/cupertino.dart';

class NewRequestController extends ChangeNotifier {
  List indexs = [];

  void add(int i) {
    indexs.add(i);
    notifyListeners();
  }

  void remove(int i) {
    indexs.remove(i);
    notifyListeners();
  }
}
