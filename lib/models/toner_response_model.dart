// To parse this JSON data, do
//
//     final tonerResponseModel = tonerResponseModelFromMap(jsonString);

import 'dart:convert';

class TonerResponseModel {
  TonerResponseModel({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  final int page;
  final int perPage;
  final int totalPages;
  final int totalItems;
  final List<Toner> items;

  factory TonerResponseModel.fromJson(String str) =>
      TonerResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TonerResponseModel.fromMap(Map<String, dynamic> json) =>
      TonerResponseModel(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Toner>.from(json["items"].map((x) => Toner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Toner {
  Toner({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.modelo,
    required this.stockMovilPoliclinico,
    required this.stockFijoPoliclinico,
    required this.stockMovilSanatorio,
    required this.stockFijoSanatorio,
  });

  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String modelo;
  final int stockMovilPoliclinico;
  final int stockFijoPoliclinico;
  final String stockMovilSanatorio;
  final String stockFijoSanatorio;

  factory Toner.fromJson(String str) => Toner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Toner.fromMap(Map<String, dynamic> json) => Toner(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        modelo: json["modelo"],
        stockMovilPoliclinico: json["stock_movil_policlinico"],
        stockFijoPoliclinico: json["stock_fijo_policlinico"],
        stockMovilSanatorio: json["stock_movil_sanatorio"],
        stockFijoSanatorio: json["stock_fijo_sanatorio"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "modelo": modelo,
        "stock_movil_policlinico": stockMovilPoliclinico,
        "stock_fijo_policlinico": stockFijoPoliclinico,
        "stock_movil_sanatorio": stockMovilSanatorio,
        "stock_fijo_sanatorio": stockFijoSanatorio,
      };
}
