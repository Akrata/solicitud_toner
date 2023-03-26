// To parse this JSON data, do
//
//     final pedidoTonerResponse = pedidoTonerResponseFromMap(jsonString);

import 'dart:convert';

class PedidoTonerResponse {
  PedidoTonerResponse({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.sector,
    required this.toner,
    this.entregado,
    this.responsable,
  });

  final String? id;
  final String? collectionId;
  final String? collectionName;
  final DateTime? created;
  final DateTime? updated;
  final String sector;
  final String toner;
  final bool? entregado;
  final String? responsable;

  factory PedidoTonerResponse.fromJson(String str) =>
      PedidoTonerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PedidoTonerResponse.fromMap(Map<String, dynamic> json) =>
      PedidoTonerResponse(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        sector: json["sector"],
        toner: json["toner"],
        entregado: json["entregado"],
        responsable: json["responsable"],
      );

  Map<String, dynamic> toMap() => {
        "sector": sector,
        "toner": toner,
      };
}
