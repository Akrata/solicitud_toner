import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import '../DB/db.dart';
import '../models/toner_response_model.dart';

class TonerDataProvider extends ChangeNotifier {
  final url = Uri.http(DB.dataBaseIp, "/api/collections/toner/records");

  List<Toner> listaToner = [];
  TonerDataProvider() {
    getToners();
  }

  getToners() async {
    try {
      final response = await http.get(url);
      final data = TonerResponseModel.fromJson(response.body);
      listaToner = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
