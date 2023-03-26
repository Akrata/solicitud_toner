import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solicitud_toner/models/pedido_toner_response.dart';
import 'package:solicitud_toner/models/toner_response_model.dart';
import 'package:solicitud_toner/provider/solicitud_toner_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = Provider.of<SolicitudTonerProvider>(context);
    bool pidioHoy = false;
    String contrasena = "";

    DateTime now;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Contraseña de administrador:"),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (value) {
                          contrasena = value;
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (contrasena == "piedra00") {
                          Navigator.popAndPushNamed(context, 'settings');
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text("Contraseña incorrecta"),
                            ),
                          );
                        }
                      },
                      child: Text("Continuar"),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.blue,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(),
          builder: (context, box, widget) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    child: ElevatedButton.icon(
                      onPressed: pidioHoy
                          ? () {
                              if (DateTime(
                                    DateTime.now().day,
                                    DateTime.now().month,
                                    DateTime.now().year,
                                  ) ==
                                  box.get("fechaUltimoPedido")) {
                                pidioHoy = true;
                              }
                              now = DateTime.now();
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy - hh:mm').format(now);
                              DateTime formattedOnlyDate =
                                  DateTime(now.day, now.month, now.year);

                              box.put("ultimoPedidoFormateado", "");
                              box.put("fechaUltimoPedido", "");

                              pedidoProvider.realizarSolicitud(
                                PedidoTonerResponse(
                                  sector: box.get("sectorID"),
                                  toner: box.get("tonerID"),
                                ),
                              );
                            }
                          : null,
                      icon: Icon(Icons.print),
                      label: Text("Solicitar Toner de impresora"),
                    ),
                  ),
                  Text(
                    "Su ultima solicitud fue : ${box.get("ultimoPedidoFormateado")}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                  if (DateTime(
                        DateTime.now().day,
                        DateTime.now().month,
                        DateTime.now().year,
                      ) ==
                      box.get("fechaUltimoPedido"))
                    Text(
                        style: TextStyle(color: Colors.red, fontSize: 25),
                        textAlign: TextAlign.center,
                        "Ya realizó un pedido en el día de hoy, no vuelva a realizar otro, Soporte está al tanto de su solicitud, y lo entregará a la brevedad")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
