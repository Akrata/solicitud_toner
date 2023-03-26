// To parse this JSON data, do
//
//     final sectorResponse = sectorResponseFromMap(jsonString);

import 'dart:convert';

class SectorResponse {
  SectorResponse({
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
    required this.items,
  });

  int page;
  int perPage;
  int totalItems;
  int totalPages;
  List<Sector> items;

  factory SectorResponse.fromJson(String str) =>
      SectorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectorResponse.fromMap(Map<String, dynamic> json) => SectorResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        items: List<Sector>.from(json["items"].map((x) => Sector.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "totalPages": totalPages,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Expand {
  Expand({
    required this.sucursal,
  });

  Sector sucursal;

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        sucursal: Sector.fromMap(json["sucursal"]),
      );

  Map<String, dynamic> toMap() => {
        "sucursal": sucursal.toMap(),
      };
}

class Sector {
  Sector({
    this.collectionId,
    this.collectionName,
    this.created,
    this.expand,
    required this.id,
    required this.nombre,
    this.sucursal,
    this.updated,
  });

  String? collectionId;
  String? collectionName;
  DateTime? created;
  Expand? expand;
  String id;
  String nombre;
  String? sucursal;
  DateTime? updated;
  @override
  String toString() {
    return "${nombre}, ${expand!.sucursal.nombre}";
  }

  factory Sector.fromJson(String str) => Sector.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sector.fromMap(Map<String, dynamic> json) => Sector(
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        expand: json["expand"] == null ? null : Expand.fromMap(json["expand"]),
        id: json["id"],
        nombre: json["nombre"],
        sucursal: json["sucursal"],
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toMap() => {
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "expand": expand?.toMap(),
        "id": id,
        "nombre": nombre,
        "sucursal": sucursal,
        "updated": updated?.toIso8601String(),
      };
}
