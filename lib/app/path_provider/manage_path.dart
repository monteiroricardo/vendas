import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ManagePath {
  static Future<File> getPath(String pathName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$pathName.json');
  }

  static Future<void> saveDataInDevice(
      File archive, List<Map<dynamic, dynamic>> data) async {
    await archive.writeAsString(json.encode(data));
  }

  static Future<List<Map<dynamic, dynamic>>> readDataFromDevice(
      File archive) async {
    List<Map<dynamic, dynamic>> data = [];
    String fileData = await archive.readAsString();
    for (var item in json.decode(fileData)) {
      data.add(item);
    }
    return data;
  }
}
