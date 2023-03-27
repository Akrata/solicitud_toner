import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solicitud_toner/models/pedido_toner_response.dart';

import '../DB/db.dart';
import 'package:http/http.dart' as http;

class SolicitudTonerProvider extends ChangeNotifier {
  final url =
      Uri.http(DB.dataBaseIp, "/api/collections/solicitud_toner/records");

  String fechaGuardado = 'fechaUltimoPedido';

  SolicitudTonerProvider() {}

  realizarSolicitud(PedidoTonerResponse toner) async {
    try {
      final response = await http.post(url,
          body: toner.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      final decodedData = response.body;
    } catch (e) {
      print(e);
    }
  }
}
