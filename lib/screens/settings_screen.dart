import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solicitud_toner/models/sector_response_model.dart';
import 'package:solicitud_toner/provider/sector_data_provider.dart';
import 'package:solicitud_toner/provider/toner_data_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectorProvider = Provider.of<SectorDataProvider>(context);
    final tonerProvider = Provider.of<TonerDataProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text("Configuracion de sector"),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(),
          builder: (context, box, widget) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text("Sector"),
                  DropdownButton(
                    items: sectorProvider.listaSectores
                        .map(
                          (e) => DropdownMenuItem<String>(
                            child: Text(e.toString()),
                            // "${e.nombre} , ${e.expand!.sucursal.nombre}"),
                            value: e.id,
                          ),
                        )
                        .toList(),

                    // value: Sector(
                    //     nombre: box.get("SectorNombre") ?? "",
                    //     id: box.get("sectorID") ?? ""),
                    onChanged: (value) {
                      // sectorProvider.sec = value!;
                      box.put("sectorID", value);
                      // box.put("sectorNombre", value.nombre);
                    },
                    value: box.get("sectorID"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Modelo de toner"),
                  DropdownButton(
                    items: tonerProvider.listaToner
                        .map(
                          (e) => DropdownMenuItem<String>(
                            child: Text(e.modelo),
                            // "${e.nombre} , ${e.expand!.sucursal.nombre}"),
                            value: e.id,
                          ),
                        )
                        .toList(),

                    // value: Sector(
                    //     nombre: box.get("SectorNombre") ?? "",
                    //     id: box.get("sectorID") ?? ""),
                    onChanged: (value) {
                      // sectorProvider.sec = value!;
                      box.put("tonerID", value);
                      // box.put("sectorNombre", value.nombre);
                    },
                    value: box.get("tonerID"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text(
                  //     "Su sector actual es : ${box.get("sectorID")} y su toner es ${box.get("tonerID")}")
                ],
              ),
            );
          },
        ));
  }
}
