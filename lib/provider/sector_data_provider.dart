import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solicitud_toner/models/sector_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../DB/db.dart';

class SectorDataProvider extends ChangeNotifier {
  final url = Uri.http(
      DB.dataBaseIp, '/api/collections/sector/records', {'expand': 'sucursal'});

  List<Sector> listaSectores = [];

  SectorDataProvider() {
    getSectores();
    // getSectorYToner();
  }

  getSectores() async {
    try {
      final response = await http.get(url);
      final data = SectorResponse.fromJson(response.body);
      listaSectores = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
